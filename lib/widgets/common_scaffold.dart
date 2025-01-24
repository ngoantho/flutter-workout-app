import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  final Widget content;
  final String title;

  const CommonScaffold({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(title)),
      ),
      body: content,
    );
  }
}
