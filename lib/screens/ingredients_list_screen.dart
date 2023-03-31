import 'package:flutter/material.dart';
import 'package:cookbook/providers/ingredients_provider.dart';
import 'package:cookbook/providers/tags_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import 'add_edit_ingredient_screen.dart';

class IngredientsListScreen extends StatelessWidget {
  static const routeName = '/ingredients-list';
  const IngredientsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingredients List'),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddEditIngredientScreen.routeName);
        },
      ),
      body: Consumer<IngredientsProvider>(
        builder: (context, ingredientsProvider, child) {
          if (ingredientsProvider.ingredients.isEmpty) {
            return const Center(
              child: Text('No ingredients yet!'),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(ingredientsProvider.ingredients[index].name),
                subtitle: Text(
                    "Unit: ${ingredientsProvider.ingredients[index].weightType.toShortString()}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AddEditIngredientScreen.routeName,
                          arguments: ingredientsProvider.ingredients[index].id,
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Are you sure?'),
                                content: const Text(
                                    'Do you want to delete this ingredient?'),
                                actions: [
                                  TextButton(
                                    child: const Text('No'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () {
                                      ingredientsProvider.removeIngredientById(
                                          ingredientsProvider
                                              .ingredients[index].id!);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  ],
                ),
              );
            },
            itemCount: ingredientsProvider.ingredientsCount,
          );
        },
      ),
    );
  }
}
