import 'package:flutter/material.dart';

import '../../mocks/category_data.dart';
import '../styles/layout.dart';
import '../widgets/category_tile.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories_screen';

  @override
  Widget build(BuildContext context) {
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
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: Layout.SPACING,
        mainAxisSpacing: Layout.SPACING,
      ),
      children: MOCK_CATEGORY_DATA
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
