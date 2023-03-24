import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/helpers/db_helper.dart';
import 'package:flutter_cookbook/models/ingredient.dart';
import 'package:flutter_cookbook/providers/recipes_provider.dart';
import 'package:flutter_cookbook/providers/tags_provider.dart';
import 'package:flutter_cookbook/themes/themes.dart';
import 'package:flutter_cookbook/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/ingredients_provider.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedValue = "pink";
  @override
  Widget build(BuildContext context) {
    var themes = Provider.of<ThemesMenager>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ThemesMenager.getSettingsRow(context),
              const SizedBox(height: 10),
              //TODO delete this button on release
              if (!kReleaseMode)
                ElevatedButton.icon(
                    onPressed: () async {
                      await Provider.of<RecipesProvider>(context, listen: false)
                          .clearRecipes();
                      Provider.of<TagsProvider>(context, listen: false)
                          .clearTags();
                      Provider.of<IngredientsProvider>(context, listen: false)
                          .clearIngredients();
                      await DBHelper.deleteDatabase();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.errorContainer),
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.onErrorContainer),
                    ),
                    icon: const Icon(Icons.delete_forever),
                    label: const Text("Delete database"))
            ],
          ),
        ),
      ),
    );
  }
}
