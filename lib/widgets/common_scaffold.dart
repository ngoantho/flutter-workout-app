import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  final String title;
  final Widget content;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;

  const CommonScaffold(
      {super.key,
      required this.title,
      required this.content,
      this.floatingActionButton,
      this.bottomSheet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: content,
      floatingActionButton: floatingActionButton,
      bottomSheet: bottomSheet,
    );
  }
}
