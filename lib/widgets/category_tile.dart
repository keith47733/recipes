import 'package:flutter/material.dart';

import '../screens/recipe_list_screen.dart';
import '../styles/layout.dart';

class CategoryTile extends StatelessWidget {
  final String categoryId;
  final String categoryTitle;
  final Color categoryColor;

  const CategoryTile({
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryColor,
  });

  void selectCategory(BuildContext screenContext) {
    Navigator.of(screenContext).pushNamed(
      RecipeListScreen.routeName,
      arguments: {
        'id': categoryId,
        'title': categoryTitle,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: categoryColor,
      borderRadius: BorderRadius.circular(Layout.RADIUS),
      child: Container(
        padding: const EdgeInsets.all(Layout.SPACING),
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
        ),
        child: Center(
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
