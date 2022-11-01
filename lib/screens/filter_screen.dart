import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/custom_app_bar.dart';
import 'package:flutter_complete_guide/widgets/custom_drawer.dart';

import '../styles/layout.dart';

// Will require StatefulWidget since switch changes will have ripple effect
// on RecipesScreen
class FilterScreen extends StatefulWidget {
  static const routeName = '/filter_screen';

  final Map<String, bool> currentFilters;
  final Function applyFilters;

  FilterScreen(this.currentFilters, this.applyFilters);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Set initial values with filterData passed as currentFilters
  // from main.dart
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
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: 'Filters'),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(Layout.SPACING),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                    'Gluten',
                    'Only include gluten free meals',
                    _isGlutenFree,
                    (newValue) => setState(() {
                      _isGlutenFree = newValue;
                    }),
                  ),
                  _buildSwitchListTile(
                    'Lactose',
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
              SizedBox(height: Layout.SPACING / 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Layout.SPACING * 2),
                child: ElevatedButton(
                  // Need to use widget. inside state class, because
                  // the saveFilters function is a property of
                  // the widget, not the state object
                  onPressed: () {
                    final selectedFilters = {
                      'gluten': _isGlutenFree,
                      'lactose': _isLactoseFree,
                      'vegan': _isVegan,
                      'vegetarian': _isVegetarian,
                    };
                    widget.applyFilters(selectedFilters);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save),
                      Text('  Apply Filters'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchListTile(String title, String subtitle, bool currentValue, Function(bool) updateValue) {
// Note we have to manage the state of the SwitchListTile
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }
}
