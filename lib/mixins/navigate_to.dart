import 'package:flutter/material.dart';

mixin NavigateMixin {
  void navigateTo({required BuildContext context, required Widget widget}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
  }

  void navigateBack({required BuildContext context}) {
    Navigator.of(context).pop();
  }
}
