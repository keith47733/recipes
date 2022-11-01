import 'package:flutter/material.dart';

import 'screens/categories_screen.dart';
import 'screens/filter_screen.dart';
import 'screens/nav_bar_screen.dart';
import 'screens/recipe_detail_screen.dart';
import 'screens/recipes_screen.dart';
import 'screens/tabs_screen.dart';
import 'styles/color_schemes.g.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes',
			debugShowCheckedModeBanner: false,
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
				// '/': (context) => TabsScreen(),
        '/': (context) => NavBarScreen(),
        // '/category_recipes_screen': (context) => CategoryRecipesScreen(),
        RecipesScreen.routeName: (context) => RecipesScreen(),
        RecipeDetailScreen.routeName: (context) => RecipeDetailScreen(),
				FilterScreen.routeName: (context) => FilterScreen(),
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
