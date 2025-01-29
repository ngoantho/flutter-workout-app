import 'package:date_only/date_only.dart';
import 'package:homework/models/output.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/measurement_unit.dart';
import 'package:homework/models/workout.dart';

final sampleWorkouts = [
  Workout(date: DateOnly(year: 2024, month: 1, day: 17), results: [
    ExerciseResult(
        exercise: Exercise(
            name: "Run 200 meters",
            targetOutput: Output(200),
            measurementUnit: MeasurementUnit.meters),
        actualOutput: Output(100)),
    ExerciseResult(
        exercise: Exercise(
            name: "Run 100 meters",
            targetOutput: Output(100),
            measurementUnit: MeasurementUnit.meters),
        actualOutput: Output(200)),
  ]),
  Workout(date: DateOnly(year: 2024, month: 1, day: 17), results: [
    ExerciseResult(
        exercise: Exercise(
            name: "Do 20 pushups",
            targetOutput: Output(20),
            measurementUnit: MeasurementUnit.repetitions),
        actualOutput: Output(25))
  ])
];