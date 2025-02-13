import 'package:flutter/material.dart';

mixin FlatButtonStyle {
  ButtonStyle get flatButtonStyle {
    return ButtonStyle(
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.zero)));
  }
}
