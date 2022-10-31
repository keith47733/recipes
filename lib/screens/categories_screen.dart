import 'package:flutter/material.dart';

import '../../mocks/category_data.dart';
import '../styles/layout.dart';
import '../widgets/category_tile.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
	

  @override
  Widget build(BuildContext context) {
    // Can use children: for fixed amount of items - otherwise builder
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(Layout.PADDING),
        child: _buildCategoryTiles(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(context) {
    return AppBar(
      title: const Text('Categories'),
    );
  }

  Widget _buildCategoryTiles() {
    return GridView(
			clipBehavior: Clip.none,
      // Slivers are scrollable areas of the screen
      // gridDelegate configures layout of grid
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        // Relationship between item's width and height
        // (eg, for 200 width, 200 * 3/2 = 300 height)
        childAspectRatio: 3 / 2,
        // Distance between colulmns and rows
        crossAxisSpacing: Layout.PADDING,
        mainAxisSpacing: Layout.PADDING,
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
