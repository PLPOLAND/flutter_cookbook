import 'package:flutter/foundation.dart';
import 'package:flutter_cookbook/helpers/db_helper.dart';
import 'package:flutter_cookbook/models/ingredient.dart';

import '../models/recipe.dart';
import '../models/tag.dart';

class RecipesProvider with ChangeNotifier {
  List<Recipe> _recipes = [];

  List<Recipe> get recipes {
    return [..._recipes];
  }

  RecipesProvider(List<Tag> tags, List<Ingredient> ingredients) {
    fetchAndSetRecipes(tags, ingredients);
  }

  /// Get the next available id for a recipe
  int get _getNextId {
    int nextId = 0;
    for (int i = 0; i < _recipes.length; i++) {
      if (_recipes.where((recipe) => recipe.id == nextId).isEmpty) {
        break;
      } else {
        nextId++;
      }
    }
    return nextId;
  }

  void fetchAndSetRecipes(List<Tag> tags, List<Ingredient> ingredients) async {
    var recipies = await DBHelper.getRecipes(tags, ingredients);
    _recipes = recipies;
    notifyListeners();
  }

  Future<Recipe> addRecipe(Recipe recipe) async {
    if (recipe.id == null) {
      var newRecipe = Recipe.id(
          id: _getNextId,
          title: recipe.title,
          description: recipe.description,
          tags: recipe.tags,
          ingredients: recipe.ingredients);
      _recipes.add(newRecipe);
      notifyListeners();
      await DBHelper.insertRecipe(newRecipe);
      return newRecipe;
    } else {
      _recipes.add(recipe);
      notifyListeners();
      await DBHelper.insertRecipe(recipe);
      return recipe;
    }
  }

  Future<Recipe> updateRecipe(Recipe recipe) async {
    print("updateRecipe: ${recipe.toString()}");
    var index = _recipes.indexWhere((element) => element.id == recipe.id);
    _recipes[index] = recipe;
    notifyListeners();
    await DBHelper.updateRecipe(recipe);
    return recipe;
  }

  /// Remove the [tag] from all recipes that contain it, then update the database
  Future<void> removeTagFromRecipes(Tag tag) async {
    for (int i = 0; i < _recipes.length; i++) {
      if (_recipes[i].tags.contains(tag)) {
        _recipes[i].tags.remove(tag);
        await DBHelper.updateRecipe(_recipes[i]);
      }
    }
    notifyListeners();
  }
}
