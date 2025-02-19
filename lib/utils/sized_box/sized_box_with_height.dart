import 'package:flutter/material.dart';

class SizedBoxWithHeight extends StatelessWidget {
  final double height;

  const SizedBoxWithHeight(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
