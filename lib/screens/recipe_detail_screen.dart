import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/models/ingredient.dart';
import 'package:flutter_cookbook/models/recipe.dart';
import 'package:flutter_cookbook/models/tag.dart';
import 'package:flutter_cookbook/widgets/recipe_detail_screen/ingredient.dart';
import 'package:flutter_cookbook/widgets/main_drawer.dart';
import 'package:flutter_cookbook/widgets/recipe_detail_screen/section_title.dart';
import 'package:flutter_cookbook/widgets/tag.dart';
import 'package:provider/provider.dart';

import '../providers/recipes_provider.dart';
import 'add_recipe_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const routeName = '/recipe-detail';

  @override
  Widget build(BuildContext context) {
    var selectedRecipeId = ModalRoute.of(context)!.settings.arguments as int;
    var selectedRecipe = Provider.of<RecipesProvider>(context)
        .recipes
        .where((element) => element.id == selectedRecipeId)
        .first;
    List<Widget> ingredientsList = [];

    selectedRecipe.ingredients.forEach((key, value) {
      ingredientsList.add(IngredientWidget(
        ingredient: key,
        amount: value,
      ));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedRecipe.title),
        actions: [
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(
                  AddRecipeScreen.routeName,
                  arguments: selectedRecipe,
                )
                    .then((value) {
                  // selectedRecipe =
                  //     Provider.of<RecipesProvider>(context, listen: false)
                  //         .recipes
                  //         .where((element) => element.id == selectedRecipeId)
                  //         .first;
                  // build(context);
                });
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.onSurface,
                ),
              )),
        ],
      ),
      // drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              selectedRecipe.image == null
                  ? Container()
                  : Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          selectedRecipe.image!.path,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              const SectionTitle("Tags"),
              Wrap(
                spacing: 0,
                children: [
                  // TagWidget.notVisible('Tagi:'),
                  ...selectedRecipe.tags.map((e) => TagWidget(e)).toList(),
                ],
              ),
              const SizedBox(height: 10),
              const SectionTitle('Składniki:'),
              const SizedBox(height: 10),
              ...ingredientsList,
              const SizedBox(height: 10),
              const SectionTitle("Przygotowanie:"),
              const SizedBox(height: 10),
              Text(
                selectedRecipe.description,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.favorite_outline),
        onPressed: () {
          //TODO: implement favorite
        },
      ),
    );
  }
}
