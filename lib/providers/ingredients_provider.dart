import 'package:flutter/material.dart';
import 'package:flutter_cookbook/helpers/db_helper.dart';
import '../models/ingredient.dart';

class IngredientsProvider with ChangeNotifier {
  List<Ingredient> _ingredients = [];

  List<Ingredient> get ingredients {
    if (isEmpty) {
      fetchAndSetIngredients();
    }
    return [..._ingredients];
  }

  /// Get the next available id for an ingredient
  int get _getNextId {
    int nextId = 0;
    for (int i = 0; i < _ingredients.length; i++) {
      if (_ingredients.where((ingredient) => ingredient.id == nextId).isEmpty) {
        break;
      } else {
        nextId++;
      }
    }
    return nextId;
  }

  Future<Ingredient> addIngredient(Ingredient ingredient) async {
    if (ingredient.id == null) {
      Ingredient newIngredient = Ingredient.id(
          id: _getNextId,
          name: ingredient.name,
          weightType: ingredient.weightType);
      _ingredients.add(newIngredient);
      await DBHelper.insertIngredient(newIngredient);
      notifyListeners();
      return ingredient;
    } else {
      _ingredients.add(ingredient);
      await DBHelper.insertIngredient(ingredient);
      notifyListeners();
      return ingredient;
    }
  }

  void removeIngredient(Ingredient ingredient) {
    _ingredients.remove(ingredient);
    DBHelper.deleteIngredient(ingredient);
    notifyListeners();
  }

  /// Remove the [ingredient] from the list of ingredients if the [ingredient] [id] matches the id passed in
  void removeIngredientById(int id) {
    DBHelper.deleteIngredient(getIngredientById(id));
    _ingredients.removeWhere((ingredient) => ingredient.id == id);
    notifyListeners();
  }

  /// Find the index of the [ingredient] with the same [id] as the [ingredient] passed in, then replace the [ingredient]
  Future<Ingredient> updateIngredient(Ingredient ingredient) {
    print(
        "updateIngredient: ${ingredient.id}, ${ingredient.name}, ${ingredient.weightType}");
    final index =
        _ingredients.indexWhere((element) => element.id == ingredient.id);
    _ingredients[index] = ingredient;
    DBHelper.updateIngredient(ingredient);
    notifyListeners();
    return Future.value(ingredient);
  }

  Ingredient getIngredientById(int id) {
    return _ingredients.firstWhere((ingredient) => ingredient.id == id);
  }

  void setIngredients(List<Ingredient> ingredients) {
    _ingredients = ingredients;
    notifyListeners();
  }

  Future<void> clearIngredients() async {
    for (var ingredient in _ingredients) {
      DBHelper.deleteIngredient(ingredient);
    }
    _ingredients = [];
    notifyListeners();
  }

  bool containsIngredient(Ingredient ingredient) {
    return _ingredients.contains(ingredient);
  }

  bool containsIngredientById(int id) {
    return _ingredients.any((ingredient) => ingredient.id == id);
  }

  int get ingredientsCount {
    return _ingredients.length;
  }

  bool get isEmpty {
    return _ingredients.isEmpty;
  }

  bool get isNotEmpty {
    return _ingredients.isNotEmpty;
  }

  Future<void> fetchAndSetIngredients() async {
    final ingredients = await DBHelper.getIngredients();
    setIngredients(ingredients);
  }
}
