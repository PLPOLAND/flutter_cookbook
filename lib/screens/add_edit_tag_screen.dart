import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tag.dart';
import '../providers/tags_provider.dart';

class AddEditTagScreen extends StatefulWidget {
  static const routeName = '/add-tag';

  const AddEditTagScreen({super.key});

  @override
  State<AddEditTagScreen> createState() => _AddEditTagScreenState();
}

class _AddEditTagScreenState extends State<AddEditTagScreen> {
  final controller = TextEditingController();
  Tag? tag;

  void save() async {
    try {
      if (controller.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tag name cannot be empty'),
            showCloseIcon: true,
          ),
        );
      } else {
        if (tag != null) {
          tag!.name = controller.text.toLowerCase();
          await Provider.of<TagsProvider>(context, listen: false)
              .updateTag(tag!);
          if (context.mounted) {
            Navigator.of(context).pop(tag);
          }
          return;
        } else {
          var newTag = await Provider.of<TagsProvider>(context, listen: false)
              .addTag(Tag(controller.text.toLowerCase()));
          if (context.mounted) {
            Navigator.of(context).pop(newTag);
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text((e as Exception).toString()),
          showCloseIcon: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tagID = ModalRoute.of(context)?.settings.arguments as int?;
    if (tagID != null) {
      tag = Provider.of<TagsProvider>(context).getTagByID(tagID);
      controller.text = tag!.name;
    }
    return Scaffold(
      appBar: AppBar(
        title: tag == null ? const Text('Add new Tag') : const Text('Edit Tag'),
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
                    print("Cancel pressed");
                    if (tag != null) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Discard changes?'),
                          content: const Text('Are you sure?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Discard'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  label: const Text('Cancel'),
                ),
                FilledButton.icon(
                  icon: const Icon(Icons.add),
                  onPressed: save,
                  label: tag == null
                      ? const Text('Add new Tag')
                      : const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
