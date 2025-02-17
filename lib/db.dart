import 'package:floor/floor.dart';
import 'package:homework/dao/exercise_results.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/enums/measurement_unit.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/models/workout_plan.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'db.g.dart';

@Database(
    version: 1, entities: [ExerciseResult, Exercise, WorkoutPlan, Workout])
abstract class AppDatabase extends FloorDatabase {
  WorkoutDao get workoutDao;
  ExerciseResultDao get exerciseResultDao;
}
