import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ingredient.dart';
import '../providers/ingredients_provider.dart';

class AddIngredientScreen extends StatefulWidget {
  static const routeName = '/add-ingredient';

  @override
  State<AddIngredientScreen> createState() => _AddIngredientScreenState();
}

class _AddIngredientScreenState extends State<AddIngredientScreen> {
  final controller = TextEditingController();
  IngredientWeightType weightType = IngredientWeightType.grams;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Ingredient'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Ingredient',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                items: [
                  for (var type in IngredientWeightType.values)
                    DropdownMenuItem(
                      value: type,
                      child: Text(type.toString()),
                    ),
                ],
                value: weightType,
                onChanged: (value) {
                  setState(() {
                    weightType = value as IngredientWeightType;
                  });
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton.icon(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    label: const Text('Cancel'),
                  ),
                  FilledButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      var addedIngredient =
                          await Provider.of<IngredientsProvider>(context,
                                  listen: false)
                              .addIngredient(Ingredient(
                                  controller.text.toLowerCase(), weightType));
                      if (context.mounted) {
                        Navigator.of(context).pop(addedIngredient);
                      }
                    },
                    label: const Text('Add new ingredient'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
