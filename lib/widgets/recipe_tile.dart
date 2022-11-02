import 'package:flutter/material.dart';

import '../screens/recipe_detail_screen.dart';
import '../styles/layout.dart';
import '../models/recipe.dart';

class RecipeTile extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  // // This variable was used when a recipe_tile .pop()s with a recipeId
  // // to not display in the recipes screen (list) - was changed to favourite
  // final Function tempRemoveRecipe;

  RecipeTile({
    required this.id,
    required this.title,
    required this.imageURL,
    required this.duration,
    required this.complexity,
    required this.affordability,
  });

  String get complexityText {
    // Could use multiple if statements
    // if (complexity == Complexity.Simple) {return 'Simple';}

    // Switch statement is better in this case
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
      // break; is often used by convention
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Pricey:
        return 'Pricey';
      case Affordability.Luxurious:
        return 'Luxurious';
      default:
        return 'Unknown';
    }
  }

  void selectRecipe(context) {
    // .pushNamed() returns a Future (indicated with -> Future<T> in docs)
    // This command "completes" when the .pushNamed screen is no longer visible
    // When "complete", .pushNamed returns an object(s)
    // (null if not specified in .pop())
    Navigator.of(context)
        .pushNamed(
      RecipeDetailScreen.routeName,
      arguments: id,
    );
		// This was required for temporary removal of recipe - changed to
		// favourite recipe
    //     .then(
    //   (result) {
    //     if (result != null) {
    //       tempRemoveRecipe(result);
    //     }
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectRecipe(context),
      child: Card(
        // Could use ClipRRect, but Card widget supports this internally
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Layout.RADIUS),
        ),
        elevation: Layout.ELEVATION,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                _buildImage(context),
                _buildTitle(context),
              ],
            ),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Layout.RADIUS),
        topRight: Radius.circular(Layout.RADIUS),
      ),
      child: Image.network(
        imageURL,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTitle(context) {
    // Position items when within a stack at distance from argument
    return Positioned(
      bottom: Layout.SPACING,
      right: Layout.SPACING / 2,
      // The container is required for the softWrap and overFlow Text arguments
      // As well background styling for white text
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        // width: 300,
        // Colors.black54 is black with 54%transparency
        // color: Colors.black54,
        padding: EdgeInsets.all(Layout.PADDING),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.54),
          borderRadius: BorderRadius.circular(Layout.RADIUS / 2),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
          // Wrap text within card container
          softWrap: true,
          // If it doesn't fit in container, even with wrapping, it will fade
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }

  Widget _buildFooter(context) {
    return Padding(
      padding: const EdgeInsets.all(Layout.PADDING),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _footerItem(context, Icons.schedule, '$duration min'),
          _footerItem(context, Icons.work, complexityText),
          _footerItem(context, Icons.attach_money, affordabilityText),
        ],
      ),
    );
  }

  Widget _footerItem(context, icon, text) {
    return Column(
      children: <Widget>[
        Icon(icon),
        SizedBox(width: Layout.SPACING / 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
