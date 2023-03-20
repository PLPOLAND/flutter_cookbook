import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/models/tag.dart';

class TagWidget extends StatelessWidget {
  final Tag? tag;
  final String? text;
  final bool notVisible;
  const TagWidget(this.tag, {super.key, this.notVisible = false}) : text = null;
  const TagWidget.notVisible(this.text, {super.key})
      : notVisible = true,
        tag = null;

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
