import 'package:flutter/material.dart';
import 'package:flutter_cookbook/providers/recipes_provider.dart';
import 'package:flutter_cookbook/screens/recipe_detail_screen.dart';
import 'package:flutter_cookbook/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import '../themes/themes.dart';

class HomePageScreen extends StatelessWidget {
  static const String routeName = '/';

  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cookbook'),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-recipe');
        },
        label: const Text('Add Recipe'),
        icon: const Icon(Icons.add),
      ),
      body: Consumer<RecipesProvider>(
        builder: (context, recipesProvider, child) {
          var recipes = recipesProvider.recipes;
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              String tags = "Tags: ";
              for (var tag in recipes[index].tags) {
                tags += "${tag.name}, ";
              }
              tags = tags.substring(0, tags.length - 2);
              return ListTile(
                title: Text(recipes[index].title),
                subtitle: Text(
                  tags,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: recipes[index].image == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.image),
                        ],
                      )
                    : Image.file(recipes[index].image!),
                onTap: () {
                  Navigator.of(context).pushNamed(RecipeDetailScreen.routeName,
                      arguments: recipes[index].id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
