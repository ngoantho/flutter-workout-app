import 'package:flutter/material.dart';

mixin NavigateMixin {
  ({void Function() back, void Function(Widget widget) to}) navigate(
      BuildContext context) {
    void to(Widget widget) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
    }

    void back() {
      Navigator.of(context).pop();
    }

    return (to: to, back: back);
  }
}
