import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/screens/HomePage.dart';
import 'package:flutter_cookbook/themes/themes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ThemesMenager.addDynamic(lightDynamic, darkDynamic);
        return MaterialApp(
          title: 'Cookbook',
          theme: ThemeData(
            colorScheme:
                ThemesMenager.getColorScheme(systemAutoBrightness: true),
            useMaterial3: true,
          ),
          home: HomePageScreen(),
        );
      },
    );
  }
}
