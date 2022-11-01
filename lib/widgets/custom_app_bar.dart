import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String title;

  const CustomAppBar({required this.appBar, required this.title});

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
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
}
