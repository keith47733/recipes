import 'package:flutter/material.dart';

import 'screens/categories_screen.dart';
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
      home: CategoriesScreen(),
    );
  }
}
