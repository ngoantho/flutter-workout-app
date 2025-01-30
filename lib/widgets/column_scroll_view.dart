import 'package:flutter/material.dart';
import 'package:homework/widgets/center_column.dart';

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
    return SingleChildScrollView(
      child: CenterColumn(children: children)
    );
  }
}
