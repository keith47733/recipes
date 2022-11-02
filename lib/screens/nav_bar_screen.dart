import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../widgets/custom_app_bar.dart';
import 'categories_screen.dart';
import 'favourites_screen.dart';
import 'filter_screen.dart';

class NavBarScreen extends StatefulWidget {
  final List<Recipe>? favouriteRecipes;

  final Map<String, bool> currentFilters;
  final Function applyFilters;

  NavBarScreen(this.favouriteRecipes, this.currentFilters, this.applyFilters);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  List<Map<String, dynamic>>? _screens;

  int _selectedScreenIndex = 0;

  @override
  void initState() {
    super.initState();
    _screens = [
      {
        'screen': CategoriesScreen(),
        'title': 'All Categories',
      },
      {
        'screen': FavouritesScreen(widget.favouriteRecipes),
        'title': 'My Favourite Recipes',
      },
      {
        'screen': FilterScreen(widget.currentFilters, widget.applyFilters),
        'title': 'My Favourite Recipes',
      },
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: _screens![_selectedScreenIndex]['title']),
      body: _screens![_selectedScreenIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
        currentIndex: _selectedScreenIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: Icon(Icons.category),
            label: 'All',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: Icon(Icons.filter),
            label: 'Filters',
          ),
        ],
      ),
    );
  }
}
