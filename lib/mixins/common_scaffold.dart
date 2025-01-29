import 'package:flutter/material.dart';

mixin CommonScaffold {
  Widget scaffold({required String title, required Widget content}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: content,
    );
  }
}