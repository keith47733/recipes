import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/category_recipes_screen.dart';

class CategoryItem extends StatelessWidget {
  final String categoryId;
  final String categoryTitle;
  final Color categoryColor;

  const CategoryItem({
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
    Navigator.of(screenContext)
        // MaterialPageRoute is a class that must be instantiated with a
        // builder that passes context to a function that returns the
        // screen you wish to 'pop on top of the stack
        .push(
      MaterialPageRoute(builder: (screenContext) {
        return CategoryRecipesScreen(
          categoryId: categoryId,
          categoryTitle: categoryTitle,
        );
      }),
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
      borderRadius: BorderRadius.circular(15.0),
      // Could use a card, but will use more customizable Container instead
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              categoryColor.withOpacity(0.2),
              categoryColor.withOpacity(0.8),
            ],
          ),
        ),
        child: Text(
          categoryTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
