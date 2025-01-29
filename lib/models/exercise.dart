import 'package:homework/models/output.dart';
import 'package:homework/models/measurement_unit.dart';

class Exercise {
  final String name;
  final Output targetOutput;
  final MeasurementUnit measurementUnit;

  const Exercise({
    required this.name,
    required this.targetOutput,
    required this.measurementUnit
  });
}