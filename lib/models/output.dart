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
    return Output(int.parse(this));
  }
}