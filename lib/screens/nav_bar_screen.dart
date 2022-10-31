import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import 'categories_screen.dart';
import 'favourites_screen.dart';

// A bottom navigation bar is added as a Scaffold argument
class NavBarScreen extends StatefulWidget {
  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  // This mapping list, where the widgets are actually screens,
  // is used in the onTap: function _selectPage and, along with
  // _selectedScreenIndex, in the body: of the Scaffold
  final List<Map<String, dynamic>> _screens = [
    {
      'screen': CategoriesScreen(),
      'title': 'All Categories',
			// 'actions': <Widget>[...],
    },
    {
      'screen': FavouritesScreen(),
      'title': 'My Favourite Recipes',
    },
  ];

  int _selectedScreenIndex = 0;

  // Flutter will automatically pass the current index from onTap:
  void _selectPage(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, _screens[_selectedScreenIndex]['title']),
      // The body is set from the _screens mapping with the current state
      // of _selectedScreenIndex
      body: _screens[_selectedScreenIndex]['screen'],
      // For navigation tabs at the bottom use a BottomNavigationBar and
      // BottomNavigationBarItems. Note, the BottomNavigationBar is not
      // automatically linked like the tab controller. You must provide
      // actions - thus, a stateful widget is requried.
      // (A tab controller can be a stateless widget)
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        // Have to style background color in each BottomNavigationBarItem
        // when using Type.shifting
        type: BottomNavigationBarType.shifting,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
        // You must tell the BottomNavigationBar what the currently
        // screen is (everytime setState is run in _selectPage)
        currentIndex: _selectedScreenIndex,
        // These items are listed as a row in the nav bar
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
        ],
      ),
    );
  }

  
}
