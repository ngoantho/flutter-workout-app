import 'package:homework/models/exercise.dart';
import 'package:homework/models/measurement_unit.dart';
import 'package:homework/models/output.dart';

class ExerciseResult {
  Exercise exercise;
  Output actualOutput;

  ExerciseResult({
    required this.exercise,
    required this.actualOutput
  });

  MeasurementUnit get measurementUnit => exercise.measurementUnit;
}