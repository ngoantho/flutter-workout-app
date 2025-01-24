import 'package:homework/models/exercise.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/measurement_unit.dart';
import 'package:homework/models/workout.dart';

final sampleWorkouts = [
  Workout(date: DateTime(2024, 1, 17), results: [
    ExerciseResult(
        exercise: Exercise(
            name: "Run 200 meters",
            targetOutput: 200,
            measurementUnit: MeasurementUnit.meters),
        actualOutput: 100),
        ExerciseResult(
        exercise: Exercise(
            name: "Run 100 meters",
            targetOutput: 100,
            measurementUnit: MeasurementUnit.meters),
        actualOutput: 200),
  ]),
  Workout(date: DateTime(2024, 1, 17), results: [
    ExerciseResult(
        exercise: Exercise(
            name: "Do 20 pushups",
            targetOutput: 20,
            measurementUnit: MeasurementUnit.repetitions),
        actualOutput: 25)
  ])
];
