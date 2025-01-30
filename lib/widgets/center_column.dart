import 'package:flutter/material.dart';

class CenterColumn extends StatelessWidget {
  final List<Widget> children;

  const CenterColumn({super.key, required this.children});

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
