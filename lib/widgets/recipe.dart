import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/recipe.dart';

class RecipeWidget extends StatelessWidget {
  const RecipeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Recipe recipe = Provider.of<Recipe>(context);
    return Card(
      child: ListTile(
        title: Text(recipe.title),
        leading: recipe.image != null
            ? Image(image: FileImage(recipe.image!))
            : null,
      ),
    );
  }
}
