// An enum maps each value to an integer 0, 1, 2 ...
enum Complexity { Simple, Challenging, Hard }

enum Affordability { Affordable, Pricey, Luxurious }

class Recipe {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;
	// Note, storing isFavourite as a property of Recipe is not realistic because
	// typically this information would be fetched from a database server. Thus,
	// the data would not be user-specific. The last user's favourites would be
	// fetched for the current user.
	// Instead, manage a list of favourites in main.dart.

  const Recipe({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });
}
