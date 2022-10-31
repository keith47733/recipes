import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const routeName = '/recipe_detail_screen';
  const RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
			body: Text('RECIPE DETAIL')
    );
  }

  PreferredSizeWidget _buildAppBar(context) {
    return AppBar(
      title: const Text('CHANGE TO RECIPE NAME'),
    );
  }
}
