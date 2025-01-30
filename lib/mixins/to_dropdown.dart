import 'package:flutter/material.dart';

mixin DropdownMenuItemsMixin {
  List<DropdownMenuItem<dynamic>> toDropdownMenuItemList(List<dynamic> values) {
    return values
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value.toString()),
            ))
        .toList();
  }
}
