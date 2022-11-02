import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'mocks/recipe_data.dart';
import 'models/recipe.dart';
import 'screens/categories_screen.dart';
import 'screens/filter_screen.dart';
import 'screens/nav_bar_screen.dart';
import 'screens/recipe_detail_screen.dart';
import 'screens/recipe_list_screen.dart';
import 'styles/app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Recipe> _availableRecipes = MOCK_RECIPE_DATA;
  List<Recipe> _favouriteRecipes = [];

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  void _applyFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableRecipes = MOCK_RECIPE_DATA.where((recipe) {
        if (_filters['gluten'] == true && !recipe.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !recipe.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !recipe.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !recipe.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isRecipeFavourite(String currentRecipeId) {
    return _favouriteRecipes.any((recipe) => recipe.id == currentRecipeId);
  }

  void _toggleFavourite(String currentRecipeId) {
    final existingIndex = _favouriteRecipes.indexWhere((recipe) => recipe.id == currentRecipeId);
    if (existingIndex >= 0) {
      setState(() {
        _favouriteRecipes.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteRecipes.add(MOCK_RECIPE_DATA.firstWhere((recipe) => recipe.id == currentRecipeId));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightColorScheme, ColorScheme? darkColorScheme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Recipes',			
          theme: AppTheme.lightTheme(lightColorScheme),
          darkTheme: AppTheme.darkTheme(darkColorScheme),
          initialRoute: '/',
          routes: {
            '/': (context) => NavBarScreen(_favouriteRecipes, _filters, _applyFilters),
            CategoriesScreen.routeName: (context) => CategoriesScreen(),
            RecipeListScreen.routeName: (context) => RecipeListScreen(_availableRecipes),
            RecipeDetailScreen.routeName: (context) => RecipeDetailScreen(_toggleFavourite, _isRecipeFavourite),
            FilterScreen.routeName: (context) => FilterScreen(_filters, _applyFilters),
          },
          onUnknownRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => NavBarScreen(_favouriteRecipes, _filters, _applyFilters),
            );
          },
        );
      },
    );
  }
}
