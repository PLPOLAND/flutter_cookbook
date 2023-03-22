import 'package:flutter/material.dart';
import 'package:flutter_cookbook/models/ingredient.dart';

class IngredientWidget extends StatelessWidget {
  final Ingredient ingredient;
  final double amount;
  const IngredientWidget(
      {super.key, required this.ingredient, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(ingredient.name),
            const SizedBox(
              width: 10,
            ),
            Text(amount.toStringAsFixed(1)),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
