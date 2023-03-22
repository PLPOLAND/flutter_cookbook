import 'package:flutter_cookbook/models/tag.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

import '../models/ingredient.dart';
import '../models/recipe.dart';

enum DBTables {
  recipes,
  ingredients,
  tags;

  @override
  String toString() {
    return super.toString().split('.').last;
  }
}

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'cookBook.db'),
      onCreate: (db, version) async {
        print('Database created');
        await db.execute(
            'CREATE TABLE ${DBTables.recipes} (id INTEGER PRIMARY KEY, name TEXT, content TEXT, ingredients TEXT, ingredients_size TEXT, tags TEXT)');
        await db.execute(
            'CREATE TABLE ${DBTables.ingredients} (id INTEGER PRIMARY KEY, name TEXT, weightType INTEGER)');
        await db.execute(
            'CREATE TABLE ${DBTables.tags} (id INTEGER PRIMARY KEY, name TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        print('Database upgraded from version $oldVersion to $newVersion');
        if (oldVersion < 3) {
          await db.execute(
              'ALTER ${DBTables.ingredients} ADD COLUMN weightType INTEGER');
        }
      },
      onConfigure: (db) {
        print('Database configured');
      },
      onDowngrade: (db, oldVersion, newVersion) =>
          print('Database downgraded from version $oldVersion to $newVersion'),
      onOpen: (db) async {
        print('Database opened');
        print('Database version: ${await db.getVersion()}');
      },
      version: 2,
    );
  }

  /// Get all tags from the database
  static Future<List<Tag>> getTags() async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query('${DBTables.tags}');
    return List.generate(maps.length, (i) {
      return Tag.id(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
    ;
  }

  /// Insert a [tag] into the database
  /// Returns the id of the inserted row.
  static Future<int> insertTag(Tag tag) async {
    final db = await DBHelper.database();
    return db.insert('${DBTables.tags}', tag.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  /// Update a [tag] in the database
  /// Returns the number of rows affected by the update operation.
  static Future<int> updateTag(Tag tag) async {
    final db = await DBHelper.database();
    return db.update('${DBTables.tags}', tag.toMap(),
        where: 'id = ?', whereArgs: [tag.id]);
  }

  /// Delete a [tag] from the database
  /// Returns the number of rows affected by the delete operation.
  static Future<int> deleteTag(Tag tag) async {
    final db = await DBHelper.database();
    return db.delete('${DBTables.tags}', where: 'id = ?', whereArgs: [tag.id]);
  }

  /// Get all ingredients from the database
  static Future<List<Ingredient>> getIngredients() async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps =
        await db.query('${DBTables.ingredients}');
    return List.generate(maps.length, (i) {
      return Ingredient.id(
        id: maps[i]['id'],
        name: maps[i]['name'],
        weightType: IngredientWeightType.values[maps[i]['weightType']],
      );
    });
  }

  /// Insert an [ingredient] into the database
  /// Returns the id of the inserted row.
  static Future<int> insertIngredient(Ingredient ingredient) async {
    final db = await DBHelper.database();
    return db.insert('${DBTables.ingredients}', ingredient.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  /// Update an [ingredient] in the database
  /// Returns the number of rows affected by the update operation.
  static Future<int> updateIngredient(Ingredient ingredient) async {
    final db = await DBHelper.database();
    return db.update('${DBTables.ingredients}', ingredient.toMap(),
        where: 'id = ?', whereArgs: [ingredient.id]);
  }

  /// Delete an [ingredient] from the database
  /// Returns the number of rows affected by the delete operation.
  static Future<int> deleteIngredient(Ingredient ingredient) async {
    final db = await DBHelper.database();
    return db.delete('${DBTables.ingredients}',
        where: 'id = ?', whereArgs: [ingredient.id]);
  }

  /// Get all recipes from the database. Needs a list of [tags] and [ingredients] to add the tags and ingredients to the recipe.
  static Future<List<Recipe>> getRecipes(
    List<Tag> tags,
    List<Ingredient> ingredients,
  ) async {
    if (tags.isEmpty || ingredients.isEmpty) {
      return [];
    }
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps =
        await db.query('${DBTables.recipes}');
    return List.generate(maps.length, (i) {
      Recipe recipe = Recipe.id(
        id: maps[i]['id'],
        description: maps[i]['content'],
        title: maps[i]['name'],
      );

      String tmpTags = maps[i]
          ['tags']; //tags are stored as a string with the ids separated by ';'
      List<String> splitedTags = tmpTags.split(';'); // split them
      splitedTags.forEach((element) {
        // add the tag of given ID to the recipe
        recipe.addTag(tags.firstWhere((tag) => tag.id == int.parse(element)));
      });

      //ingredients are stored as a string with the ids separated by ';' and the size separated by ','
      String tmpIngredientsWithSize = maps[i]['ingredients'];
      List<String> splitedIngredientsWithSize =
          tmpIngredientsWithSize.split(';'); // split ingredients
      splitedIngredientsWithSize.forEach((element) {
        List<String> ingredientWithSize =
            element.split(','); // split ingredient and size
        recipe.addIngredient(
          ingredients.firstWhere(
            (ingredient) => ingredient.id == int.parse(ingredientWithSize[0]),
          ),
          double.parse(ingredientWithSize[1]),
        );
      });
      return recipe;
    });
  }

  /// Insert a [recipe] into the database
  /// Returns the id of the inserted row.
  static Future<int> insertRecipe(Recipe recipe) async {
    final db = await DBHelper.database();
    return db.insert('${DBTables.recipes}', recipe.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  /// Update a [recipe] in the database
  /// Returns the number of rows affected by the update operation.
  static Future<int> updateRecipe(Recipe recipe) async {
    final db = await DBHelper.database();
    return db.update('${DBTables.recipes}', recipe.toMap(),
        where: 'id = ?', whereArgs: [recipe.id]);
  }

  /// Delete a [recipe] from the database
  /// Returns the number of rows affected by the delete operation.
  static Future<int> deleteRecipe(Recipe recipe) async {
    final db = await DBHelper.database();
    return db
        .delete('${DBTables.recipes}', where: 'id = ?', whereArgs: [recipe.id]);
  }

  static Future<void> deleteDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    sql.deleteDatabase(path.join(dbPath, 'cookBook.db'));
    print('Database deleted');
  }
}
