import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

import '../mocks/recipe_data.dart';
import '../styles/layout.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const routeName = '/recipe_detail_screen';

  final Function toggleFavourite;
  final Function isRecipeFavourite;

  const RecipeDetailScreen(this.toggleFavourite, this.isRecipeFavourite);

  @override
  Widget build(BuildContext context) {
    final recipeId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedRecipe = MOCK_RECIPE_DATA.firstWhere((recipe) => recipe.id == recipeId);

    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: selectedRecipe.title),
      body: _buildRecipe(context, selectedRecipe),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavourite(selectedRecipe.id),
        child: Icon(isRecipeFavourite(recipeId) ? Icons.star : Icons.star_border),
      ),
    );
  }
}

Widget _buildRecipe(context, selectedRecipe) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(Layout.SPACING),
      child: Card(
        elevation: Layout.ELEVATION,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Layout.RADIUS),
        ),
        child: Column(
          children: <Widget>[
            _buildImage(context, selectedRecipe.imageUrl),
            SizedBox(height: Layout.SPACING),
            _buildRecipeDetails(context, 'Ingredients', selectedRecipe.ingredients),
            SizedBox(height: Layout.SPACING),
            _buildRecipeDetails(context, 'Instructions', selectedRecipe.steps),
          ],
        ),
      ),
    ),
  );
}

Widget _buildImage(context, String imageUrl) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(Layout.RADIUS),
      topRight: Radius.circular(Layout.RADIUS),
    ),
    child: SizedBox(
      height: 300,
      width: double.infinity,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget _buildRecipeDetails(context, String title, List<String> details) {
  return Padding(
    padding: const EdgeInsets.all(Layout.SPACING),
    child: Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: Layout.SPACING),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: details.length,
          itemBuilder: (context, index) {
            return title == 'Ingredients'
                ? Text(
                    '•    ${details[index]}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                : ListTile(
                    leading: CircleAvatar(
											backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Text('${(index + 1)}'),
                    ),
                    title: Text(
                      details[index],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
          },
        ),
      ],
    ),
  );
}
