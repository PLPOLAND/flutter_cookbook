import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/models/ingredient.dart';
import 'package:flutter_cookbook/models/recipe.dart';
import 'package:flutter_cookbook/models/tag.dart';
import 'package:flutter_cookbook/widgets/recipe_detail_screen/ingredient.dart';
import 'package:flutter_cookbook/widgets/main_drawer.dart';
import 'package:flutter_cookbook/widgets/tag.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const routeName = '/recipe-detail';

  @override
  Widget build(BuildContext context) {
    final selectedRecipe = Recipe.id(
        id: 1,
        title: "Naleśniki",
        description:
            "Mąkę, jaja i mleko rozmieszać mikserem, dodać olej i wymieszać. Ciasto smażyć na patelni z rozgrzanym olejem.",
        imgPath:
            "https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/zapiekanka-makaronowa-pychotka.jpg");
    selectedRecipe.ingredients = {
      Ingredient.id(
          id: 0, name: "Mąka", weightType: IngredientWeightType.grams): 1000.0,
      Ingredient.id(
          id: 1, name: "Jajka", weightType: IngredientWeightType.pieces): 2.0,
      Ingredient.id(
          id: 2,
          name: "Mleko",
          weightType: IngredientWeightType.mililiters): 500.0,
      Ingredient.id(
          id: 3,
          name: "Olej",
          weightType: IngredientWeightType.mililiters): 200.0,
    };
    selectedRecipe.tags = [
      Tag.id(id: 0, name: "Śniadanie"),
      Tag.id(id: 1, name: "Obiad"),
      Tag.id(id: 2, name: "Kolacja"),
      Tag.id(id: 3, name: "Słodkie"),
      Tag.id(id: 4, name: "Wytrawne"),
    ];

    List<Widget> ingredientsList = [];

    selectedRecipe.ingredients.forEach((key, value) {
      ingredientsList.add(IngredientWidget(
        ingredient: key,
        amount: value,
      ));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedRecipe.title}'),
      ),
      // drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    selectedRecipe.image!.path,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Wrap(
                spacing: 0,
                children: [
                  // TagWidget.notVisible('Tagi:'),
                  ...selectedRecipe.tags.map((e) => TagWidget(e)).toList(),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Składniki:',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                ),
              ),
              const SizedBox(height: 10),
              ...ingredientsList,
              const SizedBox(height: 10),
              Text(
                "Przygotowanie:",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                selectedRecipe.recipeDescription,
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
