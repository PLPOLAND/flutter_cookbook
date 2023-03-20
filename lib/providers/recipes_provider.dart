import 'package:flutter/foundation.dart';

import '../models/recipe.dart';

class RecipesProvider with ChangeNotifier {
  List<Recipe> _recipes = [];

  List<Recipe> get recipes {
    return [..._recipes];
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

  void addRecipe(Recipe recipe) {
    recipe.id ??= _getNextId;
    _recipes.add(recipe);
    notifyListeners();
  }
}
