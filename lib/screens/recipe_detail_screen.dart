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
import 'add_edit_recipe_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const routeName = '/recipe-detail';

  const RecipeDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedRecipeId = ModalRoute.of(context)!.settings.arguments as int;
    // if (Provider.of<RecipesProvider>(context)
    //     .recipes
    //     .where((element) => element.id == selectedRecipeId)
    //     .isEmpty) {
    //   Navigator.of(context).pop();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: const Text('Recipe not found'),
    //       backgroundColor: Theme.of(context).colorScheme.error,
    //     ),
    //   );
    // }
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
                  AddEditRecipeScreen.routeName,
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
                        child: Hero(
                          tag: selectedRecipe.id!,
                          child: Image.file(
                            selectedRecipe.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
              const SectionTitle("Tags:"),
              Wrap(
                spacing: 0,
                children: [
                  // TagWidget.notVisible('Tagi:'),
                  ...selectedRecipe.tags.map((e) => TagWidget(e)).toList(),
                ],
              ),
              const SizedBox(height: 10),
              const SectionTitle('Ingredients:'),
              const SizedBox(height: 10),
              ...ingredientsList,
              const SizedBox(height: 10),
              const SectionTitle("Making:"),
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
      //TODO uncomment when favorite is implemented
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.favorite_outline),
      //   onPressed: () {
      //     //TODO: implement favorite
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //         content: const Text('Not implemented yet'),
      //         backgroundColor: Theme.of(context).colorScheme.error,
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
