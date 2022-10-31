import 'package:flutter/material.dart';

PreferredSizeWidget CustomAppBar(context, title) {
    return AppBar(
      // backgroundColor: Theme.of(context).colorScheme.primary,
			// foregroundColor: Theme.of(context).colorScheme.onPrimary,
      title: Text(
        title,
        // style: TextStyle(
        //   color: Theme.of(context).colorScheme.onPrimary,
        // ),
      ),
    );
  }