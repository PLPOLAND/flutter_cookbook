import 'package:flutter/material.dart';
import 'package:flutter_cookbook/dart/diacritics.dart';
import 'package:flutter_cookbook/providers/tags_provider.dart';
import 'package:provider/provider.dart';
import "package:collection/collection.dart";

import '../dart/compare_strings.dart';
import '../models/tag.dart';

class TagsChooser extends StatefulWidget {
  const TagsChooser({Key? key}) : super(key: key);

  @override
  _TagsChooserState createState() => _TagsChooserState();
}

class _TagsChooserState extends State<TagsChooser> {
  final _tags = <Tag>[];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer<TagsProvider>(builder: (context, tagsProvider, child) {
              return SizedBox(
                width: 200,
                child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Choose Tags',
                      border: OutlineInputBorder(),
                    ),
                    icon: Icon(Icons.add),
                    hint: const Text('Select tag to add it'),
                    items: getSortedTags(tagsProvider)
                        .map((tag) => DropdownMenuItem(
                              child: Text(tag.name),
                              value: tag,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        if (!_tags.contains(value)) {
                          _tags.add(value as Tag);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              behavior: SnackBarBehavior.fixed,
                              content: Text('Tag already added'),
                              showCloseIcon: true,
                              dismissDirection: DismissDirection.horizontal,
                            ),
                          );
                        }
                      });
                    }),
              );
            }),
            TextButton.icon(
              style: ButtonStyle(
                // fixedSize: MaterialStateProperty.all(Size(double.infinity, 62)),
                foregroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.onPrimaryContainer),
              ),
              icon: const Icon(Icons.add),
              onPressed: () {
                addTag();
              },
              label: const Text('Add new Tag'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          children: _tags.map((tag) {
            return ChoiceChip(
              label: Text(tag.name),
              selected: _tags.contains(tag),
              onSelected: (selected) {
                setState(() {
                  _tags.remove(tag);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  List<Tag> getSortedTags(TagsProvider tagsProvider) {
    var tags = tagsProvider.tags;
    print("unsorted tags: $tags");
    tags.sort((a, b) => compareStrings(a.name, b.name));
    print("sorted tags: $tags");
    return tags;
  }

  void addTag() {
    var controller = TextEditingController();
    showBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(labelText: 'Tag name:'),
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
                      onPressed: () {
                        Provider.of<TagsProvider>(context, listen: false)
                            .addTag(Tag(controller.text.toLowerCase()));
                        Navigator.of(context).pop();
                      },
                      label: const Text('Add new Tag'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          onClosing: () {},
        );
      },
    );
  }
}