import 'package:flutter/material.dart';

mixin NavigateMixin {
  ({void Function() back, void Function() home, void Function(Widget) to})
      navigate(BuildContext context) {
    void to(Widget widget) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
    }

    void back() {
      Navigator.of(context).pop();
    }

    void home() {
      Navigator.of(context).pushNamed('/');
    }

    return (to: to, back: back, home: home);
  }
}
