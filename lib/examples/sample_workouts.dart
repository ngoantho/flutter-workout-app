import 'package:homework/models/exercise.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/measurement_unit.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/models/output.dart';

final sampleWorkouts = [
  Workout(date: DateTime(2024, 1, 17), results: [
    ExerciseResult(
        exercise: Exercise(
            name: "Run 200 meters",
            targetOutput: Output(200, meters),
            measurementUnit: meters),
        actualOutput: Output(100, meters)),
        ExerciseResult(
        exercise: Exercise(
            name: "Run 100 meters",
            targetOutput: Output(100, meters),
            measurementUnit: meters),
        actualOutput: Output(200, meters)),
  ]),
  Workout(date: DateTime(2024, 1, 17), results: [
    ExerciseResult(
        exercise: Exercise(
            name: "Do 20 pushups",
            targetOutput: Output(20, repetitions),
            measurementUnit: repetitions),
        actualOutput: Output(25, repetitions))
  ])
];
