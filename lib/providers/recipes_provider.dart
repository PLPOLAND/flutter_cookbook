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

  void addRecipe(Recipe recipe) {
    recipe.id ??= _getNextId;
    _recipes.add(recipe);
    notifyListeners();
  }
}
