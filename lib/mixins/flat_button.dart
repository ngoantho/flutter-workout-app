import 'package:flutter/material.dart';

mixin FlatButtonStyle {
  ButtonStyle flatButtonStyle() {
    return ButtonStyle(
        shape: WidgetStateProperty.all(RoundedRectangleBorder()));
  }
}
