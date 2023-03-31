import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:cookbook/models/tag.dart';
import 'package:cookbook/providers/tags_provider.dart';
import 'package:provider/provider.dart';

class TagWidget extends StatelessWidget {
  final Tag? tag;
  final String? text;
  final bool notVisible;
  final bool dismissible;
  const TagWidget(this.tag,
      {super.key, this.notVisible = false, this.dismissible = false})
      : text = null;
  const TagWidget.notVisible(this.text, {super.key, this.dismissible = false})
      : notVisible = true,
        tag = null;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: tag == null ? ValueKey(text!) : ValueKey(tag!.id),
      direction: DismissDirection.horizontal,
      onDismissed: dismissible
          ? (direction) {
              Provider.of<TagsProvider>(context, listen: false).removeTag(tag!);
            }
          : null,
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to remove the tag?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
      child: Card(
        // color: Colors.blue
        //     .harmonizeWith(Theme.of(context).colorScheme.primaryContainer),
        color: notVisible ? Colors.transparent : null,
        shadowColor: notVisible ? Colors.transparent : null,
        elevation: notVisible ? 0 : null,
        child: Material(
          color: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              //TODO: implement onTap (navigate to page with recipes with this tag)
            },
            child: Padding(
              padding: notVisible
                  ? const EdgeInsets.symmetric(vertical: 8)
                  : const EdgeInsets.all(8.0),
              child: Text(
                !notVisible ? tag!.name : text!,
                style: TextStyle(
                    // color: Colors.white.harmonizeWith(
                    //     Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
