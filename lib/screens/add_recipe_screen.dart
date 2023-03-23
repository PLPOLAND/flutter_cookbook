import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/models/ingredient.dart';
import 'package:flutter_cookbook/models/recipe.dart';
import 'package:flutter_cookbook/widgets/tags_chooser.dart';
import 'package:provider/provider.dart';

import '../models/tag.dart';
import '../providers/recipes_provider.dart';
import '../widgets/ingredeints_chooser.dart';

class AddRecipeScreen extends StatefulWidget {
  static const routeName = '/add-recipe';

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _form = GlobalKey<FormState>();
  String name = "";
  String description = "";
  List<Tag> tags = [];
  Map<Ingredient, double> ingredients = {};

  void save() async {
    final isValid = _form.currentState!.validate();
    _form.currentState!.save();
    print(
        "save: name: $name, description: $description, tags: $tags, ingredients: $ingredients");
    if (isValid) {
      var recipe = Recipe(description: description, title: name);
      recipe.tags = tags;
      recipe.ingredients = ingredients;
      await Provider.of<RecipesProvider>(context, listen: false)
          .addRecipe(recipe);
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Recipe added'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Recipe'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name:'),
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value.';
                      }
                      if (value.length < 2) {
                        return 'Should be at least 2 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      name = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'How to make?'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value.';
                      }
                      if (value.length < 2) {
                        return 'Should be at least 2 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      description = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  IngredientsChooser(ingredients),
                  const SizedBox(height: 20),
                  TagsChooser(tags),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        label: const Text('Cancel'),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        label: const Text('Save'),
                        onPressed: () {
                          save();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
