import 'package:flutter/material.dart';

import '../screens/recipe_detail_screen.dart';
import '../styles/layout.dart';
import '../models/recipe.dart';

class RecipeTile extends StatelessWidget {
  final String title;
  final String imageURL;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  RecipeTile({
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
		Navigator.of(context).pushNamed(RecipeDetailScreen.routeName);
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
        margin: EdgeInsets.only(
          top: Layout.SPACING,
          left: Layout.SPACING,
          right: Layout.SPACING,
        ),
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
        width: 300,
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
          _recipeInfoItem(context, Icons.schedule, '$duration min'),
          _recipeInfoItem(context, Icons.work, complexityText),
          _recipeInfoItem(context, Icons.attach_money, affordabilityText),
        ],
      ),
    );
  }

  Widget _recipeInfoItem(context, icon, text) {
    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(width: Layout.SPACING / 3),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.black,
              ),
        ),
      ],
    );
  }
}
