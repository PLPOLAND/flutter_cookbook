import 'package:flutter/material.dart';
import 'package:cookbook/screens/ingredients_list_screen.dart';
import 'package:cookbook/screens/recipe_list_screen.dart';
import 'package:cookbook/screens/tags_list_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      // onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Menu'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          ListTile(
            leading: const Icon(Icons.restaurant),
            title: const Text('Recipes'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(RecipeListScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.egg),
            title: const Text('Ingredients'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(IngredientsListScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.tag),
            title: const Text('Tags'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(TagsListScreen.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed('/settings'),
          ),
        ],
      ),
    ));
  }
}
