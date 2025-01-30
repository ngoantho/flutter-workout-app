import 'package:flutter/material.dart';

class CenterRow extends StatelessWidget {
  final List<Widget> children;

  const CenterRow({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}