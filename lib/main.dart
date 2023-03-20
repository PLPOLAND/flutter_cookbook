import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/providers/ingredients_provider.dart';
import 'package:flutter_cookbook/providers/recipes_provider.dart';
import 'package:flutter_cookbook/providers/tags_provider.dart';
import 'package:flutter_cookbook/screens/HomePage.dart';
import 'package:flutter_cookbook/screens/recipe_detail_screen.dart';
import 'package:flutter_cookbook/themes/themes.dart';
import 'package:provider/provider.dart';

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
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => TagsProvider()),
            ChangeNotifierProvider(create: (_) => IngredientsProvider()),
            ChangeNotifierProxyProvider2<TagsProvider, IngredientsProvider,
                RecipesProvider>(
              create: (_) => RecipesProvider([], []),
              update: (context, tags, ingredients, previous) =>
                  RecipesProvider(tags.tags, ingredients.ingredients),
            ),
          ],
          child: MaterialApp(
            title: 'Cookbook',
            theme: ThemeData(
              colorScheme:
                  ThemesMenager.getColorScheme(systemAutoBrightness: true),
              useMaterial3: true,
            ),
            home: RecipeDetailScreen(),
            routes: {
              // HomePageScreen.routeName: (context) => const HomePageScreen(),
              RecipeDetailScreen.routeName: (context) => RecipeDetailScreen(),
            },
          ),
        );
      },
    );
  }
}
