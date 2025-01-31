import 'package:flutter/material.dart';

class SizedBoxWithWidth extends StatelessWidget {
  final double width;

  const SizedBoxWithWidth(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
