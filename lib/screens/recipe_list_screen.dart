import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../styles/layout.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/recipe_tile.dart';

class RecipeListScreen extends StatefulWidget {
  static const routeName = '/recipes_screen';

  final List<Recipe>? availableRecipes;

  RecipeListScreen(this.availableRecipes);

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  String? categoryTitle;
  List<Recipe>? displayedRecipes;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (_loadedInitData == false) {
      super.didChangeDependencies();
      final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final String categoryId = routeArgs['id'].toString();
      categoryTitle = routeArgs['title'].toString();
      displayedRecipes = widget.availableRecipes!.where((recipe) {
        return recipe.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: categoryTitle!),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: Layout.SPACING / 2,
            bottom: Layout.SPACING / 2,
            left: Layout.SPACING,
            right: Layout.SPACING,
          ),
          child: Column(
            children: [
              _buildRecipeList(context, displayedRecipes),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeList(context, displayedRecipes) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: displayedRecipes.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: Layout.SPACING / 2),
          child: RecipeTile(
            id: displayedRecipes[index].id,
            title: displayedRecipes[index].title,
            imageURL: displayedRecipes[index].imageUrl,
            duration: displayedRecipes[index].duration,
            complexity: displayedRecipes[index].complexity,
            affordability: displayedRecipes[index].affordability,
          ),
        );
      },
    );
  }
}
