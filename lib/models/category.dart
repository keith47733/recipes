import 'package:flutter/material.dart';

class Category {
	final String id;
	final String title;
	final Color color;

	// Can use const b/c once a category item is created, it will not change
	const Category({
		// required key word ensures a value is passed when instantiating class
		// for nullable variable (eg, String)
		required this.id,
		required this.title,
		// Color is not a dart item, so you have to import Flutter package
		// The color may not always be required when instantiating a Category,
		// so you have to provide default value in constructor
		this.color = Colors.orange,
	});


}