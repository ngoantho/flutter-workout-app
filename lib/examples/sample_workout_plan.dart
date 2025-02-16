import 'package:homework/models/output.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/measurement_unit.dart';
import 'package:homework/models/workout_plan.dart';

final sampleWorkoutPlan = WorkoutPlan(name: 'February 2025', exercises: [
  Exercise(
      name: 'Run 100 meters',
      target: Output(100),
      unit: MeasurementUnit.meters),
  Exercise(
      name: 'Run 200 meters',
      target: Output(200),
      unit: MeasurementUnit.meters),
  Exercise(
      name: 'Run 400 meters',
      target: Output(400),
      unit: MeasurementUnit.meters),
  Exercise(
    name: 'Squat for 15 seconds',
    target: Output(15),
    unit: MeasurementUnit.seconds,
  ),
  Exercise(
    name: 'Squat for 30 seconds',
    target: Output(30),
    unit: MeasurementUnit.seconds,
  ),
  Exercise(
    name: 'Squat for 60 seconds',
    target: Output(60),
    unit: MeasurementUnit.seconds,
  ),
  Exercise(
    name: 'Do 10 pushups',
    target: Output(10),
    unit: MeasurementUnit.repetitions,
  ),
  Exercise(
    name: 'Do 20 pushups',
    target: Output(20),
    unit: MeasurementUnit.repetitions,
  ),
  Exercise(
    name: 'Do 30 pushups',
    target: Output(30),
    unit: MeasurementUnit.repetitions,
  ),
]);
