import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cookbook/models/ingredient.dart';
import 'package:provider/provider.dart';

import '../providers/ingredients_provider.dart';
import '../screens/add_edit_tag_screen.dart';
import 'tag.dart';

/// A [SearchDelegate] that searches through a list of [Ingredient]s.
class TagSearchDelegate extends SearchDelegate<Tag?> {
  final List<Tag> listExample;
  BuildContext context;

  TagSearchDelegate(this.listExample, this.context);

  /// Opens the [AddIngredientScreen] and adds the ingredient to the list.
  void addIngredient() {
    Navigator.of(context).pushNamed(AddEditTagScreen.routeName).then((value) {
      if (value != null) {
        listExample.add(value as Tag);
      }
    });
  }

  /// Builds the actions for the [AppBar].
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

  /// Builds the leading widget for the [AppBar].
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

  /// Close the search and return the selected [Ingredient].
  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text("Type something to search"),
      );
    }
    var results = listExample.where((element) => element.name == query);
    if (results.isNotEmpty) {
      close(context, results.first);
      return Container();
    } else {
      return const Center(
        child: Text("No results found"),
      );
    }
  }

  /// Builds the list of suggestions.
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
