import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_cookbook/helpers/db_helper.dart';
import 'package:flutter_cookbook/models/ingredient.dart';
import 'package:flutter_cookbook/models/tag.dart';

class Recipe with ChangeNotifier {
  /// The id of the recipe. Can be null.
  int? _id;

  /// The title of the recipe.
  String _title;

  /// The description of the recipe.
  String _recipeDescription;

  /// The ingredients of the recipe. Can be empty.
  Map<Ingredient, double> _ingredients = {};

  /// The tags of the recipe. Can be empty.
  List<Tag> _tags = [];

  /// The image of the recipe. Can be null.
  File? _image;

  /// Constructor for a new recipe. The id is set to null.
  Recipe(
      {required String title,
      required String description,
      String? imgPath,
      List<Tag>? tags,
      Map<Ingredient, double>? ingredients})
      : _recipeDescription = description,
        _title = title {
    imgPath == null ? _image = null : _image = File(imgPath);
    tags == null ? _tags = [] : _tags = tags;
    ingredients == null ? _ingredients = {} : _ingredients = ingredients;
  }

  /// Constructor for a recipe with an id.
  Recipe.id(
      {required id,
      required String title,
      required String description,
      String? imgPath,
      List<Tag>? tags,
      Map<Ingredient, double>? ingredients})
      : _id = id,
        _recipeDescription = description,
        _title = title {
    imgPath == null ? imgPath = null : _image = File(imgPath);
    tags == null ? _tags = [] : _tags = tags;
    ingredients == null ? _ingredients = {} : _ingredients = ingredients;
  }

  /// The image of the recipe. Can be null.
  File? get image => this._image;

  /// Sets the image of the recipe and notifies the listeners.
  set image(File? value) {
    this._image = value;
    notifyListeners();
  }

  /// The id of the recipe. Can be null.
  int? get id => _id;

  /// Sets the id of the recipe and notifies the listeners.
  // set id(int? value) {
  //   _id = value;
  //   notifyListeners();
  // }
  /// The title of the recipe.
  String get title => _title;

  /// Sets the title of the recipe and notifies the listeners. Also updates the database.
  set title(String value) {
    _title = value;
    notifyListeners();
    DBHelper.updateRecipe(this);
  }

  /// The description of making the recipe.
  String get description => _recipeDescription;

  /// Sets the description of making the recipe and notifies the listeners. Also updates the database.
  set description(String value) {
    _recipeDescription = value;
    notifyListeners();
    DBHelper.updateRecipe(this);
  }

  /// The ingredients of the recipe. Can be empty.
  Map<Ingredient, double> get ingredients => _ingredients;

  /// Sets the ingredients of the recipe and notifies the listeners. Also updates the database.
  set ingredients(Map<Ingredient, double> value) {
    _ingredients = value;
    notifyListeners();
    DBHelper.updateRecipe(this);
  }

  /// The tags of the recipe. Can be empty.
  List<Tag> get tags => _tags;

  /// Sets the tags of the recipe and notifies the listeners. Also updates the database.
  set tags(List<Tag> value) {
    _tags = value;
    notifyListeners();
    DBHelper.updateRecipe(this);
  }

  /// Adds a tag to the recipe and notifies the listeners. Also updates the database.
  void addTag(Tag tag) {
    _tags.add(tag);
    notifyListeners();
    DBHelper.updateRecipe(this);
  }

  /// Returns a map of the recipe. Can be used to insert the recipe into the database.
  Map<String, Object?> toMap() {
    String ingredientsString = '';
    for (var ingredient in ingredients.keys) {
      ingredientsString += '${ingredient.id},${ingredients[ingredient]};';
    }
    String tagsString = '';
    for (var tag in tags) {
      tagsString += '${tag.id};';
    }

    return {
      'id': id ?? -1,
      'name': title,
      'content': description,
      'ingredients': ingredientsString,
      'tags': tagsString,
      'imagePath': image?.path
    };
  }

  @override
  String toString() {
    return 'Recipe(id: $id, title: $title, description: $description, ingredients: $ingredients, tags: $tags, image: $image)';
  }

  /// Adds an ingredient to the recipe and notifies the listeners.
  void addIngredient(Ingredient ingredient, double size) {
    _ingredients.putIfAbsent(ingredient, () => size);
    notifyListeners();
    DBHelper.updateRecipe(this);
  }
}
