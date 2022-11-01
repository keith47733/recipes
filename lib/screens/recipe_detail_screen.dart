import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

import '../mocks/recipe_data.dart';
import '../styles/layout.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const routeName = '/recipe_detail_screen';
  const RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The recipe's ID is passed to the detail screen and used to retrieve
    // detailed data for recipe
    final recipeId = ModalRoute.of(context)!.settings.arguments as String;
    // firstWhere() return the first recipe that matches the recipeID
    // firstWhere is run on each recipe object in RECIPE_DATA
    // (recipe) => must return true to return that recipe object
    // (eg, it only returns one recipe)
    final selectedRecipe = RECIPE_DATA.firstWhere((recipe) => recipe.id == recipeId);
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: selectedRecipe.title),
      body: _buildRecipeDetail(context, selectedRecipe),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.delete),
      ),
    );
  }
}

Widget _buildRecipeDetail(context, selectedRecipe) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(Layout.SPACING),
      child: Column(
        children: <Widget>[
          _buildImage(context, selectedRecipe.imageUrl),
          SizedBox(height: Layout.PADDING),
          _buildRecipeDetailTile(context, 'Ingredients', selectedRecipe.ingredients),
          SizedBox(height: Layout.PADDING),
          _buildRecipeDetailTile(context, 'Steps', selectedRecipe.steps),
        ],
      ),
    ),
  );
}

Widget _buildImage(context, String imageUrl) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(Layout.RADIUS),
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

Widget _buildRecipeDetailTile(context, String title, List<String> details) {
  return Card(
    elevation: Layout.ELEVATION,
    child: Padding(
      padding: const EdgeInsets.all(Layout.PADDING),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: Layout.PADDING),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: details.length,
            itemBuilder: (context, index) {
              // Alternatively, you could pass a ListView widget to this
              // _builder as an argument, Widget child, for this widget
              return title == 'Ingredients'
                  ? Text(
                      '•    ${details[index]}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.black,
                          ),
                    )
                  : ListTile(
                      leading: CircleAvatar(
                        child: Text('${(index + 1)}'),
                      ),
                      title: Text(
                        details[index],
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    );
            },
          ),
        ],
      ),
    ),
  );
}
