import 'package:flutter/material.dart';

import '../styles/layout.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter_screen';

  final Map<String, bool> currentFilters;
  final Function applyFilters;

  FilterScreen(this.currentFilters, this.applyFilters);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  @override
  void initState() {
    super.initState();
    _isGlutenFree = widget.currentFilters['gluten'] as bool;
    _isLactoseFree = widget.currentFilters['lactose'] as bool;
    _isVegan = widget.currentFilters['vegan'] as bool;
    _isVegetarian = widget.currentFilters['vegetarian'] as bool;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Layout.SPACING),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: Layout.SPACING),
            Text(
              'Adjust your recipe selection:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: Layout.SPACING),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildSwitchListTile(
                  'Gluten free',
                  'Only include gluten free meals',
                  _isGlutenFree,
                  (newValue) => setState(() {
                    _isGlutenFree = newValue;
                  }),
                ),
                _buildSwitchListTile(
                  'Lactose free',
                  'Only include lactose free meals',
                  _isLactoseFree,
                  (newValue) => setState(() {
                    _isLactoseFree = newValue;
                  }),
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan meals',
                  _isVegan,
                  (newValue) => setState(() {
                    _isVegan = newValue;
                  }),
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals',
                  _isVegetarian,
                  (newValue) => setState(() {
                    _isVegetarian = newValue;
                  }),
                ),
              ],
            ),
            SizedBox(height: Layout.SPACING),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Layout.SPACING * 4),
              child: ElevatedButton(
                onPressed: () {
                  final selectedFilters = {
                    'gluten': _isGlutenFree,
                    'lactose': _isLactoseFree,
                    'vegan': _isVegan,
                    'vegetarian': _isVegetarian,
                  };
                  widget.applyFilters(selectedFilters);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Layout.RADIUS * 1.5),
                  ),
                  elevation: Layout.ELEVATION,
                  textStyle: Theme.of(context).textTheme.titleLarge,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Layout.SPACING * 0.8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save),
                      Text('  Apply Filters'),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchListTile(String title, String subtitle, bool currentValue, Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }
}
