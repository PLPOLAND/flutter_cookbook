import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/providers/ingredients_provider.dart';
import 'package:flutter_cookbook/providers/recipes_provider.dart';
import 'package:flutter_cookbook/providers/tags_provider.dart';
import 'package:flutter_cookbook/screens/home_page.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemesMenager()),
        ChangeNotifierProvider(create: (_) => TagsProvider()),
        ChangeNotifierProvider(create: (_) => IngredientsProvider()),
        ChangeNotifierProxyProvider2<TagsProvider, IngredientsProvider,
            RecipesProvider>(
          create: (_) => RecipesProvider([], []),
          update: (context, tags, ingredients, previous) =>
              RecipesProvider(tags.tags, ingredients.ingredients),
        ),
      ],
      builder: (context, child) {
        print("build: MainApp");
        return DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) {
            Provider.of<ThemesMenager>(context, listen: false)
                .addDynamic(lightDynamic, darkDynamic);
            return MaterialApp(
              title: 'Cookbook',
              theme: ThemeData(
                colorScheme:
                    Provider.of<ThemesMenager>(context).getColorScheme(),
                // ThemesMenager.getColorScheme(systemAutoBrightness: true),
                useMaterial3: true,
              ),
              // home: RecipeDetailScreen(),
              routes: {
                HomePageScreen.routeName: (context) => const HomePageScreen(),
                RecipeDetailScreen.routeName: (context) => RecipeDetailScreen(),
              },
            );
          },
        );
      },
    );
  }
}
