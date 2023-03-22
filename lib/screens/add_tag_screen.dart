import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tag.dart';
import '../providers/tags_provider.dart';

class AddTagScreen extends StatefulWidget {
  static const routeName = '/add-tag';

  const AddTagScreen({super.key});

  @override
  State<AddTagScreen> createState() => _AddTagScreenState();
}

class _AddTagScreenState extends State<AddTagScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Tag'),
      ),
      body: Padding(
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
                    var tag = Provider.of<TagsProvider>(context, listen: false)
                        .addTag(Tag(controller.text.toLowerCase()));
                    Navigator.of(context).pop(tag);
                  },
                  label: const Text('Add new Tag'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
