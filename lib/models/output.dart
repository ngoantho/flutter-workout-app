import 'package:homework/models/measurement_unit.dart';

class Output {
  final int value;
  final MeasurementUnit unit;

  Output(this.value, this.unit);

  static bool isSuccessful({required Output actual, required Output target}) {
    assert(actual.unit == target.unit);
    return actual.value >= target.value;
  }

  @override
  String toString() {
    return '$value ${unit.name}';
  }
}
