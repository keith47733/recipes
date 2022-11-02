import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../styles/layout.dart';
import '../widgets/recipe_tile.dart';

// Until we learn more about state management, if you un-favourite a recipe,
// it will not be reflected when you go back to a "cached" version of the
// FavouritesScreen (from RecipeDetailScreen) sitting on the stack.
// This is a problem with managing state from main.dart.
// You would have to turn this into a Stateful widget and pass functions, etc
// to manage from main.dart - not gonna bother!
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
    // Use ListView.builder to render only items that are on-screen
    // and when you don't know the item count ahead of time
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: favouriteRecipes.length,
      itemBuilder: (BuildContext context, int index) {
        // displayedRecipes is based on a class with .variables
        // not ['named'] variables like a Firebase Firestore
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
