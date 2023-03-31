import 'package:flutter/material.dart';
import 'package:cookbook/models/ingredient.dart';

class IngredientWidget extends StatelessWidget {
  final Ingredient ingredient;
  final double amount;
  final bool showTopBorder;
  const IngredientWidget(
      {super.key,
      required this.ingredient,
      required this.amount,
      this.showTopBorder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: showTopBorder
              ? BorderSide(
                  color: Theme.of(context).colorScheme.onSurface, width: 1)
              : BorderSide.none,
          bottom: BorderSide(
              color: Theme.of(context).colorScheme.onSurface, width: 1),
        ),
      ),
      height: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(ingredient.name),
            Text(
                "${amount.toStringAsFixed(1)} ${ingredient.weightType.toShortString()}"),
          ],
        ),
      ),
    );
  }
}
