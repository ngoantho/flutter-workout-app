import 'package:flutter/material.dart';

mixin DropdownMenuMixin<T> {
  List<DropdownMenuItem<T>> toDropdownMenuItemList(List<T> values) {
    return values.map((value) => toDropdownMenuItem(value)).toList();
  }

  DropdownMenuItem<T> toDropdownMenuItem(T value) {
    return DropdownMenuItem(value: value, child: Text(value.toString()));
  }
}
