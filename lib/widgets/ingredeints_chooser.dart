import 'package:flutter/material.dart';
import 'package:flutter_cookbook/models/ingredient_search_delegate.dart';
import 'package:flutter_cookbook/providers/ingredients_provider.dart';
import 'package:provider/provider.dart';

import '../models/ingredient.dart';

class IngredientsChooser extends StatefulWidget {
  final Map<Ingredient, double> ingredients;
  IngredientsChooser(this.ingredients, {Key? key}) : super(key: key);

  @override
  _IngredientsChooserState createState() => _IngredientsChooserState();
}

class _IngredientsChooserState extends State<IngredientsChooser> {
  void chooseIngredientFromList() async {
    var ingredient = await showSearch(
        context: context,
        delegate: IngredientSearchDelegate(
            Provider.of<IngredientsProvider>(context, listen: false)
                .ingredients,
            context));
    print('ingredient: $ingredient');
    if (ingredient != null) {
      setState(() {
        if (widget.ingredients.containsKey(ingredient)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ingredient already added'),
              showCloseIcon: true,
            ),
          );
        } else {
          widget.ingredients.putIfAbsent(ingredient, () => 0);
        }
      });
    }
  }

  void showEditValueDialog(BuildContext context, TextEditingController controll,
      int index, double val) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit amount'),
            content: TextField(
              controller: controll,
              decoration: InputDecoration(
                  labelText:
                      'Amount in "${widget.ingredients.keys.elementAt(index).weightType.toShortString()}"',
                  border: const OutlineInputBorder()),
              autofocus: true,
              keyboardType: TextInputType.number,
              onEditingComplete: () {
                setState(() {
                  widget.ingredients.update(
                      widget.ingredients.keys.elementAt(index), (value) => val);
                });
                Navigator.of(context).pop();
              },
              onTapOutside: (event) {
                setState(() {
                  widget.ingredients.update(
                      widget.ingredients.keys.elementAt(index), (value) => val);
                });
                Navigator.of(context).pop();
              },
              onChanged: (value) {
                setState(() {
                  val = double.parse(value);
                });
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              const Text('Ingredients', textAlign: TextAlign.center),
              Positioned(
                right: 0,
                child: IconButton(
                  onPressed: () {
                    chooseIngredientFromList();
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height:
              40.0 * widget.ingredients.length, //40.0 is the height of the row
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.horizontal,
                key: ValueKey(widget.ingredients.keys.elementAt(index)),
                onDismissed: (direction) {
                  setState(() {
                    widget.ingredients
                        .remove(widget.ingredients.keys.elementAt(index));
                  });
                },
                background: Container(
                  color: Theme.of(context).colorScheme.error,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: const Icon(Icons.delete),
                ),
                secondaryBackground: Container(
                  color: Theme.of(context).colorScheme.error,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: index != 0
                          ? BorderSide.none
                          : const BorderSide(color: Colors.grey, width: 1),
                      bottom: const BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.ingredients.keys.elementAt(index).name),
                        Row(
                          children: [
                            Text(
                                "${widget.ingredients.values.elementAt(index).toStringAsFixed(1)} ${widget.ingredients.keys.elementAt(index).weightType.toShortString()}"),
                            IconButton(
                                onPressed: () {
                                  var val = widget.ingredients.values
                                      .elementAt(index);
                                  var controll = TextEditingController(
                                    text: val.toStringAsFixed(1),
                                  );
                                  controll.selection = TextSelection(
                                      baseOffset: 0,
                                      extentOffset: controll.text.length - 2);
                                  showEditValueDialog(
                                      context, controll, index, val);
                                },
                                icon: const Icon(Icons.edit)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: widget.ingredients.keys.length,
          ),
        ),
      ],
    );
  }
}
