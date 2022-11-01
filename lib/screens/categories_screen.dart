import 'package:flutter/material.dart';

import '../../mocks/category_data.dart';
import '../models/recipe.dart';
import '../styles/layout.dart';
import '../widgets/category_tile.dart';

class CategoriesScreen extends StatelessWidget {
static const routeName = '/categories_screen';

  @override
  Widget build(BuildContext context) {
    // Can use children: for fixed amount of items - otherwise builder
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(Layout.SPACING),
        child: Column(
          children: [
            _buildCategoryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      // clipBehavior: Clip.none,
      // Slivers are scrollable areas of the screen
      // gridDelegate configures layout of grid
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        // Relationship between item's width and height
        // (eg, for 200 width, 200 * 3/2 = 300 height)
        childAspectRatio: 3 / 2,
        // Distance between colulmns and rows
        crossAxisSpacing: Layout.SPACING,
        mainAxisSpacing: Layout.SPACING,
      ),
      // Map each item of our CATEGORY_DATA to a function that creates a widget
      children: CATEGORY_DATA
          .map(
            (categoryData) => CategoryTile(
              categoryId: categoryData.id,
              categoryTitle: categoryData.title,
              categoryColor: categoryData.color,
            ),
          )
          .toList(),
    );
  }
}
