import 'package:homework/models/output.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/measurement_unit.dart';
import 'package:homework/models/workout_plan.dart';

final sampleWorkoutPlan = WorkoutPlan(name: 'February 2025', exercises: [
  Exercise(
      name: 'Run 100 meters',
      targetOutput: Output(100),
      measurementUnit: MeasurementUnit.meters),
  Exercise(
      name: 'Run 200 meters',
      targetOutput: Output(200),
      measurementUnit: MeasurementUnit.meters),
  Exercise(
      name: 'Run 400 meters',
      targetOutput: Output(400),
      measurementUnit: MeasurementUnit.meters),
  Exercise(
    name: 'Squat for 15 seconds',
    targetOutput: Output(15),
    measurementUnit: MeasurementUnit.seconds,
  ),
  Exercise(
    name: 'Squat for 30 seconds',
    targetOutput: Output(30),
    measurementUnit: MeasurementUnit.seconds,
  ),
  Exercise(
    name: 'Squat for 60 seconds',
    targetOutput: Output(60),
    measurementUnit: MeasurementUnit.seconds,
  ),
  Exercise(
    name: 'Do 10 pushups',
    targetOutput: Output(10),
    measurementUnit: MeasurementUnit.repetitions,
  ),
  Exercise(
    name: 'Do 20 pushups',
    targetOutput: Output(20),
    measurementUnit: MeasurementUnit.repetitions,
  ),
  Exercise(
    name: 'Do 30 pushups',
    targetOutput: Output(30),
    measurementUnit: MeasurementUnit.repetitions,
  ),
]);