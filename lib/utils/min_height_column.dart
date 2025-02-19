import 'package:flutter/material.dart';

class MinHeightColumn extends StatelessWidget {
  final List<Widget> children;

  const MinHeightColumn(this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
