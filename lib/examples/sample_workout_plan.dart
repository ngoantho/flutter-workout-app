import 'package:homework/models/exercise.dart';
import 'package:homework/enums/measurement_unit.dart';
import 'package:homework/models/workout_plan.dart';

final sampleWorkoutPlan = WorkoutPlan(name: 'February 2025');
final exercises = [
  Exercise(name: 'Run 100 meters', target: 100, unit: meters),
  Exercise(name: 'Run 200 meters', target: 200, unit: meters),
  Exercise(name: 'Run 400 meters', target: 400, unit: meters),
  Exercise(
    name: 'Squat for 15 seconds',
    target: 15,
    unit: seconds,
  ),
  Exercise(
    name: 'Squat for 30 seconds',
    target: 30,
    unit: seconds,
  ),
  Exercise(
    name: 'Squat for 60 seconds',
    target: 60,
    unit: seconds,
  ),
  Exercise(
    name: 'Do 10 pushups',
    target: 10,
    unit: repetitions,
  ),
  Exercise(
    name: 'Do 20 pushups',
    target: 20,
    unit: repetitions,
  ),
  Exercise(
    name: 'Do 30 pushups',
    target: 30,
    unit: repetitions,
  ),
];
