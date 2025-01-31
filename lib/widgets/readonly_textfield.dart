import 'package:flutter/material.dart';
import 'package:homework/classes/disabled_focus_node.dart';

class ReadonlyTextField extends StatelessWidget {
  final String labelText;
  final String value;

  const ReadonlyTextField({
    super.key,
    required this.labelText,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      initialValue: value,
      focusNode: DisabledFocusNode(),
    );
  }
}
