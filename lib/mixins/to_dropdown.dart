import 'package:flutter/material.dart';

mixin DropdownMenuItemsMixin {
  List<DropdownMenuItem<dynamic>> toDropdownMenuItemList(List<dynamic> values) {
    return values
        .map((value) => toDropdownMenuItem(value))
        .toList();
  }

  DropdownMenuItem<dynamic> toDropdownMenuItem(dynamic value) {
    return DropdownMenuItem(value: value, child: Text(value.toString()));
  }
}
