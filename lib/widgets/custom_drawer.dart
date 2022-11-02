import 'package:flutter/material.dart';

import '../screens/filter_screen.dart';
import '../styles/layout.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildTitle(context, 'Cooking Up!'),
          const SizedBox(height: Layout.SPACING),
          _buildMenuItem(
            context,
            Icon(Icons.restaurant),
            'Recipes',
            () {
							// This would repeatedly add more and more screens to stack
              // Navigator.of(context).pushNamed('/');
							// pushReplacementNamed() clears the entire stack and starts
							// over with new screen (eg, routing after a login page)
							// pushReplacement() when using Material router instead of routes
							Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          _buildMenuItem(
            context,
            Icon(Icons.settings),
            'Filter Recipes',
            () {
              Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(context, title) {
    return Container(
      height: 120,
      width: double.infinity,
      padding: EdgeInsets.all(Layout.SPACING),
      // Align everything in container vertical center, horiz left
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    Icon icon,
    String title,
    // Need to use a VoidCallback function here
    VoidCallback tapHandler,
  ) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        // style: Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: tapHandler,
    );
  }
}
