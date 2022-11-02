import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../styles/layout.dart';
import '../widgets/recipe_tile.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Recipe>? favouriteRecipes;

  FavouritesScreen(this.favouriteRecipes);

  @override
  Widget build(BuildContext context) {
    if (favouriteRecipes!.isEmpty) {
      return Center(child: Text('You have no favourites yet.'));
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: Layout.SPACING / 2,
            bottom: Layout.SPACING / 2,
            left: Layout.SPACING,
            right: Layout.SPACING,
          ),
          child: Column(
            children: [
              _buildRecipeList(context, favouriteRecipes),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildRecipeList(context, favouriteRecipes) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: favouriteRecipes.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: Layout.SPACING / 2),
          child: RecipeTile(
            id: favouriteRecipes[index].id,
            title: favouriteRecipes[index].title,
            imageURL: favouriteRecipes[index].imageUrl,
            duration: favouriteRecipes[index].duration,
            complexity: favouriteRecipes[index].complexity,
            affordability: favouriteRecipes[index].affordability,
          ),
        );
      },
    );
  }
}
