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

  const AddRecipeScreen({Key? key}) : super(key: key);

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _form = GlobalKey<FormState>();
  Recipe? recipe;
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
      if (recipe != null) {
        recipe!.title = name;
        recipe!.description = description;
        recipe!.tags = tags;
        recipe!.ingredients = ingredients;
        await Provider.of<RecipesProvider>(context, listen: false)
            .updateRecipe(recipe!);
        if (context.mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Recipe updated'),
            ),
          );
        }
        return;
      }
      var newRecipe = Recipe(description: description, title: name);
      newRecipe.tags = tags;
      newRecipe.ingredients = ingredients;
      await Provider.of<RecipesProvider>(context, listen: false)
          .addRecipe(newRecipe);
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
    if (ModalRoute.of(context)!.settings.arguments != null) {
      recipe = ModalRoute.of(context)!.settings.arguments as Recipe;
      name = recipe!.title;
      description = recipe!.description;
      tags = recipe!.tags;
      ingredients = recipe!.ingredients;
    }

    return Scaffold(
        appBar: AppBar(
          title: recipe == null
              ? const Text('Add Recipe')
              : const Text('Edit Recipe'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: name,
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
                    initialValue: description,
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
                          if (recipe != null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Cancel changes'),
                                    content: const Text(
                                        'Are you sure? All changes will be lost.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            Navigator.of(context).pop();
                          }
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
