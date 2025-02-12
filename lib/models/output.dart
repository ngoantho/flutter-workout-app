import 'package:flutter/material.dart';

class Output {
  int value;

  Output(this.value);

  static bool isSuccessful({required Output actual, required Output target}) {
    return actual.value >= target.value;
  }

  @override
  String toString() {
    return value.toString();
  }
}

extension StringToOutput on String {
  Output toOutput() {
    if (this == '') return Output(0);
    return Output(int.parse(this));
  }
}

extension ControllerToOutput on TextEditingController {
  set output(int value) {
    final currentOutput = text.toOutput();
    currentOutput.value = value;
    text = currentOutput.toString();
  }

  int get output => text.toOutput().value;

  bool get hasOutput => text.isNotEmpty;
}
