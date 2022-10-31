import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/recipe_detail_screen.dart';

import 'screens/categories_screen.dart';
import 'screens/category_recipes_screen.dart';
import 'styles/color_schemes.g.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes',
      theme: ThemeData(
        fontFamily: 'RobotoCondensed',
        useMaterial3: true,
        colorScheme: lightColorScheme,
        // Use only 2021 text types
        textTheme: ThemeData.light().textTheme.copyWith(
              bodySmall: TextStyle(
                color: Color(0xFF79747E),
              ),
              bodyMedium: TextStyle(
                color: Color(0xFF79747E),
              ),
              bodyLarge: TextStyle(
                color: Color(0xFF79747E),
              ),
              titleLarge: TextStyle(
                fontFamily: 'RaleWay',
              ),
            ),
      ),
      darkTheme: ThemeData(
        fontFamily: 'Raleway',
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      // home: is the root screen of app
      // home: CategoriesScreen(),
      // Can also set initialRoute to default home route
      initialRoute: '/',
      routes: {
        // The home: argument will default to '/': if not named above
        '/': (context) => CategoriesScreen(),
        // '/category_recipes_screen': (context) => CategoryRecipesScreen(),
        CategoryRecipesScreen.routeName: (context) => CategoryRecipesScreen(),
        RecipeDetailScreen.routeName: (context) => RecipeDetailScreen(),
      },
    );
  }
}
