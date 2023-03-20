import 'package:flutter/foundation.dart';
import 'package:flutter_cookbook/models/ingredient.dart';
import 'package:flutter_cookbook/models/tag.dart';

class Recipe with ChangeNotifier {
  int? _id;
  String _title;
  String _recipeDescription;
  List<Ingredient> _ingredients = [];
  List<Tag> _tags = [];

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

  List<Ingredient> get ingredients => _ingredients;
  set ingredients(List<Ingredient> value) {
    _ingredients = value;
    notifyListeners();
  }

  List<Tag> get tags => _tags;
  set tags(List<Tag> value) {
    _tags = value;
    notifyListeners();
  }

  Recipe({required String title, required String description})
      : _recipeDescription = description,
        _title = title;

  Recipe.id({required id, required String title, required String description})
      : _id = id,
        _recipeDescription = description,
        _title = title;

  Map<String, Object?> toMap() {
    String ingredientsString = '';
    for (var ingredient in ingredients) {
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
}
