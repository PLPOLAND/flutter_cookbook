import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:cookbook/providers/ingredients_provider.dart';
import 'package:cookbook/providers/recipes_provider.dart';
import 'package:cookbook/providers/tags_provider.dart';
import 'package:cookbook/screens/add_edit_ingredient_screen.dart';
import 'package:cookbook/screens/add_edit_recipe_screen.dart';
import 'package:cookbook/screens/add_edit_tag_screen.dart';
import 'package:cookbook/screens/home_page.dart';
import 'package:cookbook/screens/ingredients_list_screen.dart';
import 'package:cookbook/screens/recipe_detail_screen.dart';
import 'package:cookbook/screens/recipe_list_screen.dart';
import 'package:cookbook/screens/settings_screen.dart';
import 'package:cookbook/screens/tags_list_screen.dart';
import 'package:cookbook/themes/themes.dart';
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
        // print(
        //     "build: MainApp with theme: ${Provider.of<ThemesMenager>(context).theme}");
        return DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) {
            Provider.of<ThemesMenager>(context, listen: false)
                .addDynamic(lightDynamic, darkDynamic);
            return MaterialApp(
              title: 'Cookbook',
              theme: ThemeData(
                colorScheme: Provider.of<ThemesMenager>(context)
                    .getColorScheme(systemAutoBrightness: true),
                // ThemesMenager.getColorScheme(systemAutoBrightness: true),
                useMaterial3: true,
              ),
              // home: RecipeDetailScreen(),
              routes: {
                HomePageScreen.routeName: (context) => const HomePageScreen(),
                RecipeListScreen.routeName: (context) =>
                    const RecipeListScreen(),
                RecipeDetailScreen.routeName: (context) => RecipeDetailScreen(),
                AddEditRecipeScreen.routeName: (context) =>
                    AddEditRecipeScreen(),
                AddEditTagScreen.routeName: (context) => AddEditTagScreen(),
                AddEditIngredientScreen.routeName: (context) =>
                    AddEditIngredientScreen(),
                TagsListScreen.routeName: (context) => const TagsListScreen(),
                IngredientsListScreen.routeName: (context) =>
                    const IngredientsListScreen(),
                SettingsScreen.routeName: (context) => SettingsScreen(),
              },
            );
          },
        );
      },
    );
  }
}
