import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cookbook/models/ingredient.dart';
import 'package:provider/provider.dart';

import '../providers/ingredients_provider.dart';

class IngredientSearchDelegate extends SearchDelegate<Ingredient?> {
  final List<Ingredient> listExample;
  BuildContext context;

  IngredientSearchDelegate(this.listExample, this.context);

  void addIngredient() {
    Navigator.of(context).pushNamed('/add-ingredient').then((value) {
      if (value != null) {
        listExample.add(value as Ingredient);
      }
    });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
      IconButton(
        onPressed: () {
          addIngredient();
        },
        icon: const Icon(Icons.add),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, listExample.where((element) => element.name == query).first);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = query.isEmpty
        ? listExample.map((e) => e.name).toList()
        : listExample
            .where((element) => element.name.toLowerCase().startsWith(query))
            .toList()
            .map((e) => e.name)
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            close(
                context,
                listExample
                    .where((element) => suggestionList[index] == element.name)
                    .first);
          },
          leading: const Icon(Icons.add),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(
                    color: Color.alphaBlend(const Color(0xA2FFFFF0),
                        Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
