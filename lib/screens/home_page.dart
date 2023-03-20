import 'package:flutter/material.dart';
import 'package:flutter_cookbook/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import '../themes/themes.dart';

class HomePageScreen extends StatelessWidget {
  static const String routeName = '/';

  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hello World!'),
      ),
      appBar: AppBar(
        title: const Text('Cookbook'),
      ),
      drawer: MainDrawer(),
      floatingActionButton: Consumer<ThemesMenager>(
        builder: (context, value, child) {
          return FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).pushNamed('/add-recipe');
            },
            label: const Text('Add Recipe'),
            icon: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
