import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:cookbook/helpers/db_helper.dart';

/// An ingredient that can be used in a recipe.
class Ingredient extends Equatable with ChangeNotifier {
  /// The id of the ingredient.
  int? _id;

  /// The name of the ingredient.
  String _name;

  /// The type of weight of the ingredient.
  IngredientWeightType _weightType;

  IngredientWeightType get weightType => _weightType;
  set weightType(IngredientWeightType value) {
    _weightType = value;
    notifyListeners();
    DBHelper.updateIngredient(this);
  }

  /// The id of the ingredient.
  int? get id => _id;

  /// The name of the ingredient.
  String get name => _name;

  /// Sets the name of the ingredient and updates the database.
  set name(String value) {
    _name = value;
    notifyListeners();
    DBHelper.updateIngredient(this);
  }

  /// Creates a new ingredient. The id is set to null.
  Ingredient(String name, IngredientWeightType ingredientWeightType)
      : _name = name,
        _weightType = ingredientWeightType;

  /// Creates a new ingredient with the id.
  Ingredient.id(
      {required int id,
      required String name,
      required IngredientWeightType weightType})
      : _id = id,
        _name = name,
        _weightType = weightType;

  /// Creates a Map from the ingredients fields.
  Map<String, Object?> toMap() {
    return {
      'id': id ?? -1,
      'name': name,
      'weightType': weightType.index,
    };
  }

  @override
  String toString() {
    return 'Ingredient{id: $id, name: $name}';
  }

  @override
  List<Object?> get props => [id];
}

enum IngredientWeightType {
  grams, //gramy,
  cups, //szklanki,
  tablespoons, //łyżki stołowe,
  teaspoons, //łyżeczki,
  pieces, //sztuki,
  slices, //plasterki,
  cans, //puszki,
  bottles, //butelki,
  mililiters; //mililitry,

  /// Returns a string representation of the enum.
  @override
  String toString() {
    switch (this) {
      case IngredientWeightType.grams:
        return 'grams';
      case IngredientWeightType.cups:
        return 'cups';
      case IngredientWeightType.tablespoons:
        return 'tablespoons';
      case IngredientWeightType.teaspoons:
        return 'teaspoons';
      case IngredientWeightType.pieces:
        return 'pieces';
      case IngredientWeightType.slices:
        return 'slices';
      case IngredientWeightType.cans:
        return 'cans';
      case IngredientWeightType.bottles:
        return 'bottles';
      case IngredientWeightType.mililiters:
        return 'mililiters';
    }
  }

  /// Returns a short string representation of the enum.
  String toShortString() {
    switch (this) {
      case IngredientWeightType.grams:
        return 'g';
      case IngredientWeightType.cups:
        return 'cups';
      case IngredientWeightType.tablespoons:
        return 'tbsp';
      case IngredientWeightType.teaspoons:
        return 'tsp';
      case IngredientWeightType.pieces:
        return 'pcs';
      case IngredientWeightType.slices:
        return 'slices';
      case IngredientWeightType.cans:
        return 'cans';
      case IngredientWeightType.bottles:
        return 'bottle';
      case IngredientWeightType.mililiters:
        return 'ml';
    }
  }
}
