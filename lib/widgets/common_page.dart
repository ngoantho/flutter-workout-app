import 'package:flutter/material.dart';

abstract class CommonPage extends StatelessWidget {
  String get title;

  const CommonPage({super.key});

  Widget content(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: content(context),
    );
  }
}
