import 'package:flutter/material.dart';
import 'package:flutter_cookbook/providers/recipes_provider.dart';
import 'package:flutter_cookbook/providers/tags_provider.dart';
import 'package:flutter_cookbook/screens/add_edit_tag_screen.dart';
import 'package:flutter_cookbook/widgets/tag.dart';
import 'package:provider/provider.dart';

class TagsList extends StatelessWidget {
  TagsList();

  @override
  Widget build(BuildContext context) {
    var tagsProv = Provider.of<TagsProvider>(context);
    return tagsProv.isEmpty
        ? const Center(
            child: Text("No tags yet"),
          )
        : ListView.builder(
            itemCount: tagsProv.tags.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tagsProv.tags[index].name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            AddEditTagScreen.routeName,
                            arguments: tagsProv.tags[index].id);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Delete tag"),
                              content: const Text("Are you sure?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await Provider.of<RecipesProvider>(context,
                                            listen: false)
                                        .removeTagFromRecipes(
                                            tagsProv.tags[index]);
                                    tagsProv.removeTag(tagsProv.tags[index]);
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
  }
}
