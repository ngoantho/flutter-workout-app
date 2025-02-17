import 'package:flutter/material.dart';

typedef Output = int;
bool isSuccessful({required Output actual, required Output target}) {
  return actual >= target;
}

extension StringToOutput on String {
  Output toOutput() {
    if (this == '') return 0;
    return int.parse(this);
  }
}

extension ControllerToOutput on TextEditingController {
  set output(int value) {
    text = value.toString();
  }

  int get output => text.toOutput();

  bool get hasOutput => text.isNotEmpty;
}
