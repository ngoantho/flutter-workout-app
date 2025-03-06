import 'package:flutter/material.dart';
import 'package:homework/classes/disabled_focus_node.dart';

class ReadonlyTextField extends StatelessWidget {
  final String labelText;
  final String value;
  final bool enabled;

  const ReadonlyTextField(
      {super.key,
      required this.labelText,
      required this.value,
      this.enabled = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration:
          InputDecoration(labelText: labelText, border: InputBorder.none),
      initialValue: value,
      focusNode: (!enabled) ? DisabledFocusNode() : null,
    );
  }
}
