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

  Output operator + (int value) {
    return Output(this.value + value);
  }
}

extension StringToOutput on String {
  Output toOutput() {
    if (this == '') return Output(0);
    return Output(int.parse(this));
  }
}
