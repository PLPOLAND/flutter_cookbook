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
          return FloatingActionButton(
            onPressed: () {
              if (value.themeMode == ThemeMode.dark) {
                value.setThemeMode(ThemeMode.light);
              } else {
                value.setThemeMode(ThemeMode.dark);
              }
            },
            child: const Icon(Icons.brightness_6),
          );
        },
      ),
    );
  }
}
