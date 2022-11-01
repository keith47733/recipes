import 'package:flutter/material.dart';

import '../mocks/recipe_data.dart';
import '../styles/layout.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/recipe_tile.dart';

class RecipesScreen extends StatelessWidget {
  // Can define the route name for each screen as a const
  // static allows you to access the variable w/o instantiating class
  static const routeName = '/recipes_screen';
  // You can then refer to this variable in the main.dart route map

  // Typical class variables and constructor:
  // final categoryId;
  // final categoryTitle;
  // const CategoryRecipesScreen({
  //   super.key,
  //   required this.categoryId,
  //   this.categoryTitle,
  // });

  // Arguments from named routes are dealt with in build()

  @override
  Widget build(BuildContext context) {
    // ModalRoute is a class for handling arguments passed through routes
    // ModalRoute must be used in build() in order to get context
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String categoryId = routeArgs['id'].toString();
    final String categoryTitle = routeArgs['title'].toString();

    // "Query" RECIPE_DATA for recipes with a category that matches
    // the selected category
    // .where() requires a test or function and returns matches
    final categoryRecipes = RECIPE_DATA.where((recipe) {
      // Return a recipe where it's list of categories contains the
      // current categoryId
      return recipe.categories.contains(categoryId);
    }).toList();

    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: categoryTitle),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Layout.SPACING / 2,
            horizontal: Layout.SPACING,
          ),
          child: Column(
            children: [
              _buildRecipeList(context, categoryRecipes),
            ],
          ),
        ),
      ),
    );
  }

	// NOTE: YOU COULD OPTIMIZE THE APP HERE BY CREATING THIS AS A
	// SEPARATE STATELESS WIDGET...ANYTIME YOU CALL OF(CONTEXT) WILL
	// TRIGGER A REBUILD OF THIS ENTIRE SCREEN INSTEAD OF JUST THE BUILDER
	// EG, IF THE THEME CHANGES AND AFFECTS CONTEXT
  Widget _buildRecipeList(context, categoryRecipes) {
    // Use ListView.builder to render only items that are on-screen
    // and when you don't know the item count ahead of time
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: categoryRecipes.length,
      itemBuilder: (BuildContext context, int index) {
        // categoryRecipes is based on a class with .variables
        // not ['named'] variables like a Firebase Firestore
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: Layout.SPACING / 2),
          child: RecipeTile(
            id: categoryRecipes[index].id,
            title: categoryRecipes[index].title,
            imageURL: categoryRecipes[index].imageUrl,
            duration: categoryRecipes[index].duration,
            complexity: categoryRecipes[index].complexity,
            affordability: categoryRecipes[index].affordability,
          ),
        );
      },
    );
  }
}
