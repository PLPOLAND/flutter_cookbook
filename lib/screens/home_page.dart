import 'package:flutter/material.dart';
import 'package:cookbook/models/recipe_search_delegate.dart';
import 'package:cookbook/providers/recipes_provider.dart';
import 'package:cookbook/screens/recipe_detail_screen.dart';
import 'package:cookbook/widgets/main_drawer.dart';
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
        actions: [
          IconButton(
            onPressed: () async {
              var recipe = await showSearch(
                context: context,
                delegate: RecipeSearchDelegate(
                    Provider.of<RecipesProvider>(context, listen: false)
                        .recipes,
                    context),
              );
              if (recipe != null && context.mounted) {
                Navigator.of(context).pushNamed(RecipeDetailScreen.routeName,
                    arguments: recipe.id);
              }
            },
            icon: const Icon(Icons.search),
          ),
        ],
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 2
                          : 3,
                ),
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  String tags = "Tags: ";
                  for (var tag in recipes[index].tags) {
                    tags += "${tag.name}, ";
                  }
                  tags = tags.substring(0, tags.length - 2);
                  return Card(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        splashColor: Theme.of(context).colorScheme.primary,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RecipeDetailScreen.routeName,
                            arguments: recipes[index].id,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: recipes[index].image == null
                                    ? const Icon(Icons.image)
                                    : Hero(
                                        tag: recipes[index].id!,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.file(
                                            recipes[index].image!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                recipes[index].title,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                tags,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              // TextButton(
                              //   onPressed: () {
                              //     Navigator.of(context).pushNamed(
                              //       RecipeDetailScreen.routeName,
                              //       arguments: recipes[index].id,
                              //     );
                              //   },
                              //   child: const Text('View Recipe'),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
