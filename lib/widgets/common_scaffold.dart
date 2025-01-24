import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  final Widget widget;
  final String title;

  const CommonScaffold(this.widget, {super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(title)),
      ),
      body: widget,
    );
  }
}
