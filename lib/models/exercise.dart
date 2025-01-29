import 'package:homework/models/output.dart';
import 'package:homework/models/measurement_unit.dart';

class Exercise {
  String name;
  Output targetOutput;
  MeasurementUnit measurementUnit;

  Exercise({
    required this.name,
    required this.targetOutput,
    required this.measurementUnit
  });
}