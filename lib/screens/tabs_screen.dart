import 'package:flutter/material.dart';

import 'categories_screen.dart';
import 'favourites_screen.dart';

// A tab controller can be a stateless widget b/c Flutter handles
// all the behind-the-scenes 'navigation'
// The home: of Material() should be tabs_screen.dart
class TabsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // For tabs at the top of the screen use a DefaultTabController
    // The DefaultTabController links the TabBar and Tab widgets
    return DefaultTabController(
      length: 2,
			// Index corresponds to lists below (index starts at zero)
			// initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            'Categories',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.category), text: 'All'),
              Tab(icon: Icon(Icons.star), text: 'Favourites'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            // The order of the screens should match order of Tab above
						// These screens should not include their own Scaffold - the
						// Scaffold from this screen is used
            CategoriesScreen(),
            FavouritesScreen(),
          ],
        ),
      ),
    );
  }
}
