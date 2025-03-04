import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;

  const CommonAppBar(this.title, {super.key, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [homeButton(context)],
      bottom: (subtitle != null) ? subtitleWidget() : null,
    );
  }

  PreferredSizeWidget subtitleWidget() => PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight / 2),
      child: Text(subtitle!));

  IconButton homeButton(BuildContext context) => IconButton(
      onPressed: () {
        Navigator.of(context).pushReplacementNamed('/');
      },
      icon: Icon(Icons.home));

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
