import 'package:flutter/material.dart';
import 'package:flutter_cookbook/providers/tags_provider.dart';
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
        : Wrap(
            spacing: 8.0,
            // runSpacing: 4.0,
            children: tagsProv.tags
                .map((tag) => TagWidget(
                      tag,
                      dismissible: true,
                    ))
                .toList(),
          );
  }
}
