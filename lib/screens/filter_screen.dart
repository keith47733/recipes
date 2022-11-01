import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/custom_app_bar.dart';
import 'package:flutter_complete_guide/widgets/custom_drawer.dart';

class FilterScreen extends StatelessWidget {
	static const routeName = '/filter_screen';

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: CustomAppBar(appBar: AppBar(), title: 'Filters'),
			drawer: CustomDrawer(),
			body: Center(child: Text('Filters')),
		);
	}
}