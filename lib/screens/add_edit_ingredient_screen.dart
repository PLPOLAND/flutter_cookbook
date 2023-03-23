import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ingredient.dart';
import '../providers/ingredients_provider.dart';

class AddEditIngredientScreen extends StatefulWidget {
  static const routeName = '/add-ingredient';
  IngredientWeightType weightType = IngredientWeightType.grams;

  AddEditIngredientScreen({super.key});

  @override
  State<AddEditIngredientScreen> createState() =>
      _AddEditIngredientScreenState();
}

class _AddEditIngredientScreenState extends State<AddEditIngredientScreen> {
  Ingredient? ingredient;
  final controller = TextEditingController();
  late IngredientWeightType weightType;

  @override
  void initState() {
    print("Init state");
    weightType = widget.weightType;
    super.initState();
  }

  void save() {
    if (ingredient != null) {
      print("Updating ingredient: ${ingredient!.name} -> ${controller.text}"
          " and weight type: ${ingredient!.weightType} -> ${widget.weightType}");
      ingredient!.name = controller.text;
      ingredient!.weightType = widget.weightType;
      Provider.of<IngredientsProvider>(context, listen: false)
          .updateIngredient(ingredient!);
    } else {
      Provider.of<IngredientsProvider>(context, listen: false)
          .addIngredient(Ingredient(controller.text, weightType));
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      ingredient = Provider.of<IngredientsProvider>(context, listen: true)
          .getIngredientById(ModalRoute.of(context)!.settings.arguments as int);
      controller.text = ingredient!.name;
      weightType = ingredient!.weightType;
    }
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
                    widget.weightType = value as IngredientWeightType;
                    weightType = value;
                    print("New weight type: $weightType");
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
                    icon: Icon(ingredient == null ? Icons.add : Icons.save),
                    onPressed: () {
                      save();
                    },
                    label: ingredient == null
                        ? const Text('Add new ingredient')
                        : const Text('Save changes'),
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
