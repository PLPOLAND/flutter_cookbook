import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/widgets/tags_chooser.dart';

class AddRecipeScreen extends StatefulWidget {
  static const routeName = '/add-recipe';

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _form = GlobalKey<FormState>();
  String name = "";
  String description = "";
  var tags = "";
  var ingredients = "";

  void save() {}

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
                  TagsChooser(),
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
