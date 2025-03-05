import 'package:flutter/material.dart';

mixin NavigateMixin {
  ({void Function(dynamic) back, void Function(Widget) to}) navigate(
      BuildContext context) {
    void to(Widget widget) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
    }

    void back(dynamic value) {
      Navigator.of(context).pop(value);
    }

    return (to: to, back: back);
  }
}
