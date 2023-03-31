import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:cookbook/models/ingredient.dart';
import 'package:cookbook/models/recipe.dart';
import 'package:cookbook/widgets/tags_chooser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

import '../models/tag.dart';
import '../providers/recipes_provider.dart';
import '../widgets/ingredeints_chooser.dart';

class AddEditRecipeScreen extends StatefulWidget {
  static const routeName = '/add-recipe';

  const AddEditRecipeScreen({Key? key}) : super(key: key);

  @override
  _AddEditRecipeScreenState createState() => _AddEditRecipeScreenState();
}

class _AddEditRecipeScreenState extends State<AddEditRecipeScreen> {
  final _form = GlobalKey<FormState>();
  Recipe? recipe;
  String name = "";
  String description = "";
  List<Tag> tags = [];
  Map<Ingredient, double> ingredients = {};
  File? img;

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

        if (img != null) {
          final appDir = await syspaths.getApplicationDocumentsDirectory();
          final fileName = path.basename(img!.path);
          final savedImage = await img!.copy('${appDir.path}/$fileName');
          recipe!.image = savedImage;
        }
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
      } else {
        var newRecipe = Recipe(description: description, title: name);
        if (img != null) {
          final appDir = await syspaths.getApplicationDocumentsDirectory();
          final fileName = path.basename(img!.path);
          final savedImage = await img!.copy('${appDir.path}/$fileName');
          newRecipe.image = savedImage;
        }
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
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      recipe = ModalRoute.of(context)!.settings.arguments as Recipe;
      name = recipe!.title;
      description = recipe!.description;
      tags = recipe!.tags;
      ingredients = recipe!.ingredients;
      img = recipe!.image;
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: img == null ? 100 : 116,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    Theme.of(context).colorScheme.onSurface)),
                        child: img == null
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text("No image selected"),
                                ),
                              )
                            : Image.file(img!),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.camera_alt),
                            label: const Text('Take a picture'),
                            onPressed: () async {
                              final image = await ImagePicker().pickImage(
                                  source: ImageSource.camera,
                                  imageQuality: 50,
                                  maxWidth: 600);
                              if (image != null) {
                                setState(() {
                                  img = File(image.path);
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.image),
                            label: const Text('From gallery'),
                            onPressed: () async {
                              final image = await ImagePicker().pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 50);
                              if (image != null) {
                                setState(() {
                                  img = File(image.path);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
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
