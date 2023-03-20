import 'package:flutter/material.dart';
import 'package:flutter_cookbook/widgets/main_drawer.dart';

import '../themes/themes.dart';

class HomePageScreen extends StatelessWidget {
  static const String routeName = '/';

  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hello World!'),
      ),
      appBar: AppBar(
        title: const Text('Cookbook'),
      ),
      drawer: MainDrawer(),
    );
  }
}
