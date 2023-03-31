import 'package:flutter/material.dart';
import 'package:cookbook/widgets/main_drawer.dart';
import '../widgets/tags_list.dart';

class TagsListScreen extends StatelessWidget {
  static const String routeName = '/tags-list';

  const TagsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tags'),
        ),
        drawer: MainDrawer(),
        body: TagsList(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamed('/add-tag');
          },
          label: const Text('Add Tag'),
          icon: const Icon(Icons.add),
        ));
  }
}
