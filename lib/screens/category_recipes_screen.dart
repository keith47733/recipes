import 'package:flutter/material.dart';

class CategoryRecipesScreen extends StatelessWidget {
  final categoryId;
  final categoryTitle;

  const CategoryRecipesScreen({
    super.key,
    required this.categoryId,
    this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: Text(
          categoryTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(categoryTitle),
    );
  }
}
