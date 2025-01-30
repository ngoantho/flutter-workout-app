import 'package:flutter/material.dart';

class DisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

mixin ReadonlyTextFieldMixin {
  TextFormField readOnlyTextField({
    required String labelText,
    required String value,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      initialValue: value,
      focusNode: DisabledFocusNode(),
    );
  }
}