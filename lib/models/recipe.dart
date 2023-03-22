import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_cookbook/models/ingredient.dart';
import 'package:flutter_cookbook/models/tag.dart';

class Recipe with ChangeNotifier {
  int? _id;
  String _title;
  String _recipeDescription;
  Map<Ingredient, double> _ingredients = {};
  List<Tag> _tags = [];
  File? _image;

  Recipe({required String title, required String description, String? imgPath})
      : _recipeDescription = description,
        _title = title {
    imgPath == null ? imgPath = null : _image = File(imgPath);
  }

  Recipe.id(
      {required id,
      required String title,
      required String description,
      String? imgPath})
      : _id = id,
        _recipeDescription = description,
        _title = title {
    imgPath == null ? imgPath = null : _image = File(imgPath);
  }

  File? get image => this._image;
  set image(File? value) {
    this._image = value;
    notifyListeners();
  }

  int? get id => _id;
  set id(int? value) {
    _id = value;
    notifyListeners();
  }

  String get title => _title;

  set title(String value) {
    _title = value;
    notifyListeners();
  }

  String get recipeDescription => _recipeDescription;
  set recipeDescription(String value) {
    _recipeDescription = value;
    notifyListeners();
  }

  Map<Ingredient, double> get ingredients => _ingredients;
  set ingredients(Map<Ingredient, double> value) {
    _ingredients = value;
    notifyListeners();
  }

  List<Tag> get tags => _tags;
  set tags(List<Tag> value) {
    _tags = value;
    notifyListeners();
  }

  void addTag(Tag tag) {
    _tags.add(tag);
    notifyListeners();
  }

  Map<String, Object?> toMap() {
    String ingredientsString = '';
    for (var ingredient in ingredients.keys) {
      ingredientsString += '${ingredient.id};';
    }
    String tagsString = '';
    for (var tag in tags) {
      tagsString += '${tag.id};';
    }

    return {
      'id': id ?? -1,
      'name': title,
      'description': recipeDescription,
      'ingredients': ingredientsString,
      'tags': tagsString,
    };
  }

  void addIngredient(Ingredient ingredient, double size) {
    _ingredients.putIfAbsent(ingredient, () => size);
    notifyListeners();
  }
}
