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

  String get exerciseName => exercise.name;
  set exerciseName(String name) => exercise.name = name; 

  Output get targetOutput => exercise.targetOutput;
  set targetOutput(Output output) => exercise.targetOutput = output;

  MeasurementUnit get measurementUnit => exercise.measurementUnit;
  set measurementUnit(MeasurementUnit unit) => exercise.measurementUnit = unit;

  @override
  String toString() {
    return 'Exercise: ($exercise), actual: $actualOutput';
  }
}