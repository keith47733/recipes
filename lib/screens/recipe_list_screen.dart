import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../styles/layout.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/recipe_tile.dart';

// This widget/screen class was converted to Stateful b/c we want to
// update the recipe list with the tempRemovedRecipe returned form
// RecipeTile() < RecipeDetailScreen()
class RecipeListScreen extends StatefulWidget {
  // Can define the route name for each screen as a const
  // static allows you to access the variable w/o instantiating class
  // You can then refer to this variable in the main.dart route map
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

  // The recipe list build was moved from build() to initState(), since it can
  // be modified by temporarily removing a recipe (RecipeDetail)
  // HOWEVER, the recipe list build was then moved to .didDependenciesChange()
  // because we use ModalRoute which relies on context...but the context is
  // available until the widget is built
  // @override
  // void initState() {
  //   super.initState();
  // }

  // initState is run before the widget is completely built, thus commands
  // that rely on context typically won't work.
  // eg, ModalRoute
  @override
  void didChangeDependencies() {
    // didDependenciesChange() can run multiple times throughout
    // widget/screen rebuild. This ensures the list build is only run
    // the first time
    if (_loadedInitData == false) {
      super.didChangeDependencies();
      // ModalRoute is a class for handling arguments passed through routes
      // ModalRoute must be used in build() or didDependenciesChange()
      // in order to get context
      final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final String categoryId = routeArgs['id'].toString();
      categoryTitle = routeArgs['title'].toString();
      // "Query" RECIPE_DATA for recipes with a category that matches
      // the selected category
      // .where() requires a test or function and returns matches
      displayedRecipes = widget.availableRecipes!.where((recipe) {
        // .where() returns a recipe where it's list of categories contains the
        // current categoryId
        return recipe.categories.contains(categoryId);
      }).toList();
      // Set to true only after the displayedRecipes is generated
      _loadedInitData = true;
    }
  }

  // Functions go in the State class outside the build()
  void _tempRemoveRecipe(tempRemoveRecipeId) {
    // Putting the .removeWhere() in a SetState will remove the recipe
    // from displayedRecipes and refresh the screen
    setState(() {
      displayedRecipes!.removeWhere((recipe) => recipe.id == tempRemoveRecipeId);
    });
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

  // NOTE: YOU COULD OPTIMIZE THE APP HERE BY CREATING THIS AS A
  Widget _buildRecipeList(context, displayedRecipes) {
    // Use ListView.builder to render only items that are on-screen
    // and when you don't know the item count ahead of time
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: displayedRecipes.length,
      itemBuilder: (BuildContext context, int index) {
        // displayedRecipes is based on a class with .variables
        // not ['named'] variables like a Firebase Firestore
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
