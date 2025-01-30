import 'package:flutter/material.dart';

class ColumnScrollView extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;

  const ColumnScrollView(
    this.children, {
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        children: children,
      ),
    );
  }
}

class CenterColumnScrollView extends StatelessWidget {
  final List<Widget> children;

  const CenterColumnScrollView(this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    return ColumnScrollView(children, mainAxisAlignment: MainAxisAlignment.center,);
  }
}
