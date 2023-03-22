import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cookbook/helpers/db_helper.dart';

class Ingredient extends Equatable with ChangeNotifier {
  int? _id;
  String _name;
  IngredientWeightType _weightType;

  IngredientWeightType get weightType => _weightType;
  set weightType(IngredientWeightType value) {
    _weightType = value;
    notifyListeners();
    DBHelper.updateIngredient(this);
  }

  int? get id => this._id;
  // set id(int? value) => _id = value;

  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
    DBHelper.updateIngredient(this);
  }

  Ingredient(String name, IngredientWeightType ingredientWeightType)
      : _name = name,
        _weightType = ingredientWeightType;
  Ingredient.id(
      {required int id,
      required String name,
      required IngredientWeightType weightType})
      : _id = id,
        _name = name,
        _weightType = weightType;

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

  @override
  String toString() {
    switch (this) {
      case IngredientWeightType.grams:
        return 'gramy';
      case IngredientWeightType.cups:
        return 'szklanki';
      case IngredientWeightType.tablespoons:
        return 'łyżki stołowe';
      case IngredientWeightType.teaspoons:
        return 'łyżeczki';
      case IngredientWeightType.pieces:
        return 'sztuki';
      case IngredientWeightType.slices:
        return 'plasterki';
      case IngredientWeightType.cans:
        return 'puszki';
      case IngredientWeightType.bottles:
        return 'butelki';
      case IngredientWeightType.mililiters:
        return 'mililitry';
    }
  }

  String toShortString() {
    switch (this) {
      case IngredientWeightType.grams:
        return 'g';
      case IngredientWeightType.cups:
        return 'szkl.';
      case IngredientWeightType.tablespoons:
        return 'łyżki';
      case IngredientWeightType.teaspoons:
        return 'łyżeczki';
      case IngredientWeightType.pieces:
        return 'szt.';
      case IngredientWeightType.slices:
        return 'plasterki';
      case IngredientWeightType.cans:
        return 'pusz.';
      case IngredientWeightType.bottles:
        return 'but.';
      case IngredientWeightType.mililiters:
        return 'ml';
    }
  }
}
