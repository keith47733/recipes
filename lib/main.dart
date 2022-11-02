import 'package:flutter/material.dart';

import 'mocks/recipe_data.dart';
import 'models/recipe.dart';
import 'screens/categories_screen.dart';
import 'screens/filter_screen.dart';
import 'screens/nav_bar_screen.dart';
import 'screens/recipe_detail_screen.dart';
import 'screens/recipe_list_screen.dart';
import 'styles/color_schemes.g.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // USING SETSTATE() IN MAIN.DART WILL REBUILD ENTIRE APP
  // WHICH IS NOT OPTIMAL - THERE ARE MUCH BETTER WAYS TO HANDLE STATE

  // main.dart was converted to Stateful widget in order to use
  // setState to update the _filters Map with data received from FilterScreen,
  // favourites recipes, etc

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  // Note, we'll now have to manage available meals in main.dart, not in
  // recipe list using RECIPE_DATA
  List<Recipe> _availableRecipes = MOCK_RECIPE_DATA;
  // Initially set _favouritedRecipes to empty[]
  // Manage adding favourites in main.dart so it can be passed around
  List<Recipe> _favouriteRecipes = [];

  void _toggleFavourite(String currentRecipeId) {
    final existingIndex = _favouriteRecipes.indexWhere((recipe) => recipe.id == currentRecipeId);
    if (existingIndex >= 0) {
      setState(() {
        _favouriteRecipes.removeAt(existingIndex);
      });
    } else {
      setState(() {
        // Use MOCK_RECIPE_DATA so favourites can be picked from all recipes
        // w/o the filter(s) applied
        _favouriteRecipes.add(MOCK_RECIPE_DATA.firstWhere((recipe) => recipe.id == currentRecipeId));
      });
    }
  }

  bool _isRecipeFavourite(String currentRecipeId) {
    return _favouriteRecipes.any((recipe) => recipe.id == currentRecipeId);
  }

  // This method will be called when user clicks Apply Filters in
  // the FilterScreen
  void _applyFilters(Map<String, bool> filterData) {
    setState(() {
      // We'll make sure filterData returned by FilterScreen is exact same
      // map as _filters
      _filters = filterData;
      // .toList() converts the RECIPE_DATA map to a list
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'RobotoCondensed',
        // useMaterial3: true,
        // colorScheme: lightColorScheme,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        // Use default 2021 text types
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyMedium: TextStyle(
                fontFamily: 'RobotoCondensed',
                // color: Colors.white,
              ),
              bodyLarge: TextStyle(
                fontFamily: 'RaleWay',
              ),
              titleMedium: TextStyle(
                fontFamily: 'RaleWay',
              ),
              titleLarge: TextStyle(
                fontFamily: 'RaleWay',
              ),
            ),
      ),
      darkTheme: ThemeData(
        fontFamily: 'RobotoCondensed',
        // useMaterial3: true,
        // colorScheme: darkColorScheme,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      // home: is the root screen of app
      // home: CategoriesScreen(),
      // Can also set initialRoute to default home route
      initialRoute: '/',
      routes: {
        // The home: argument will default to '/': if not named above
        // '/': (context) => TabsScreen(),
        '/': (context) => NavBarScreen(_favouriteRecipes),
        // '/category_recipes_screen': (context) => CategoriesScreen(),
        CategoriesScreen.routeName: (context) => CategoriesScreen(),
        RecipeListScreen.routeName: (context) => RecipeListScreen(_availableRecipes),
        RecipeDetailScreen.routeName: (context) => RecipeDetailScreen(_toggleFavourite, _isRecipeFavourite),
        // For now, need to convert main.dart to Stateful widget
        // in order to pass/reflect changes data from FilterScreen to
        // RecipeListScreen using the _setFilters setState function,
        // since FilterScreen is called from CustomDrawer
        FilterScreen.routeName: (context) => FilterScreen(_filters, _applyFilters),
      },
      // Flutter will default to onGenerateRoute (which returns a function w
      // MaterialPageRoute) if Dart tries to generate a pushNamed screen not
      // registered in route table above
      // Settings refers to the attempted pushNamed route
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(
      //     builder: (context) => CategoriesScreen(),
      //   );
      // },
      // Flutter will, as a last resort before throwing an error, default to
      // this argument if pushNamed refers to route not in route map above
      // (eg, 404 page)
      onUnknownRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(
          builder: (context) => CategoriesScreen(),
        );
      },
    );
  }
}
