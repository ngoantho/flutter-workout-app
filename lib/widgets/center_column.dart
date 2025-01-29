import 'package:flutter/material.dart';

class CenterColumn extends StatelessWidget {
  final List<Widget> children;

  const CenterColumn(this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(), // <- need this
        ...children,
      ],
    );
  }
}
