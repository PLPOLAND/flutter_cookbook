import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/providers/ingredients_provider.dart';
import 'package:flutter_cookbook/providers/recipes_provider.dart';
import 'package:flutter_cookbook/providers/tags_provider.dart';
import 'package:flutter_cookbook/screens/add_edit_ingredient_screen.dart';
import 'package:flutter_cookbook/screens/add_edit_recipe_screen.dart';
import 'package:flutter_cookbook/screens/add_tag_screen.dart';
import 'package:flutter_cookbook/screens/home_page.dart';
import 'package:flutter_cookbook/screens/ingredients_list_screen.dart';
import 'package:flutter_cookbook/screens/recipe_detail_screen.dart';
import 'package:flutter_cookbook/screens/settings_screen.dart';
import 'package:flutter_cookbook/screens/tags_list_screen.dart';
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
        // print(
        //     "build: MainApp with theme: ${Provider.of<ThemesMenager>(context).theme}");
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
                AddEditRecipeScreen.routeName: (context) =>
                    AddEditRecipeScreen(),
                AddTagScreen.routeName: (context) => AddTagScreen(),
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
