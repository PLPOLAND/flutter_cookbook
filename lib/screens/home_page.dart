import 'package:flutter/material.dart';
import 'package:flutter_cookbook/providers/recipes_provider.dart';
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
        builder: (context, value, child) {
          return Center(
            child: Text(
              'Recipes: ${value.recipes.length}',
            ),
          );
        },
      ),
    );
  }
}
