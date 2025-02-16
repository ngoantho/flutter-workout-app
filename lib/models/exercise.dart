import 'package:homework/models/output.dart';
import 'package:homework/models/measurement_unit.dart';

class Exercise {
  String name;
  Output target;
  MeasurementUnit unit;

  Exercise({required this.name, required this.target, required this.unit});

  @override
  String toString() {
    return '$name, target: $target, unit: $unit';
  }
}
