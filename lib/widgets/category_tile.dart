import 'package:flutter/material.dart';

import '../screens/recipe_list_screen.dart';
import '../styles/layout.dart';

class CategoryTile extends StatelessWidget {
  final String categoryId;
  final String categoryTitle;
  final Color categoryColor;

  const CategoryTile({
    super.key,
    // Need to use required b/c variables are defined above but could have null values
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryColor,
  });

  void selectCategory(BuildContext screenContext) {
    // Navigator is a class to help navigate between screens
    // Needs context so it 'knows where it currently is' in the widget tree
    // Picture navigation as a 'stack' (eg, a deck of cards)
    // push() screen on top of stack, pop() screen from the top of stack

    // MaterialPageRoute is a class that must be instantiated with a
    // builder that passes context to a function that returns the
    // screen you wish to 'pop on top of the stack

    // Navigator.of(screenContext).push(
    // MaterialPageRoute(builder: (screenContext) {
    //   return CategoryRecipesScreen(
    //     categoryId: categoryId,
    //     categoryTitle: categoryTitle,
    //   );
    // }),);

    // OR..using named routes (see main.dart) with arguments
    Navigator.of(screenContext).pushNamed(
      // Using name from route map:
      //'/category_recipes_screen',
      // OR...from class routeName const (after importing class):
      RecipeListScreen.routeName,
      arguments: {
        'id': categoryId,
        'title': categoryTitle,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // InkWell is basically GestureDetector but with a ripple effect
    return InkWell(
      // onTap: don't refer to function with () - () tries to instantiate
      // Need to bind anonymous function so you can pass arguments
      onTap: () => selectCategory(context),
      splashColor: categoryColor,
      //splashColor: Theme.of(context).primaryColor,
      // Ideally border radius is same as child
      borderRadius: BorderRadius.circular(Layout.RADIUS),
      // Could use a card, but will use more customizable Container instead
      child: Container(
        padding: const EdgeInsets.all(Layout.PADDING),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Layout.RADIUS),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              categoryColor.withOpacity(0.2),
              categoryColor.withOpacity(0.8),
            ],
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: categoryColor.withOpacity(0.5),
          //     blurRadius: 3.0, // How blurry the effect is
          //     spreadRadius: 3.0, // Size of shadow
          //     // offset: Offset(5, 5), // changes position of shadow
          //   ),
          // ],
        ),
        child: Center(
          // Center child horizontally AND vertically
          heightFactor: double.infinity,
          widthFactor: double.infinity,
          child: Text(
            categoryTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
