class Output {
  final int value;

  const Output(this.value);

  static bool isSuccessful({required Output actual, required Output target}) {
    return actual.value >= target.value;
  }

  @override
  String toString() {
    return value.toString();
  }
}