import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:homework/models/workout.dart';
import 'package:provider/provider.dart';

@dao
abstract class WorkoutDao {
  @Query('SELECT * FROM workout')
  Future<List<Workout>> getAllWorkouts();

  @Query(
      'SELECT * FROM workout WHERE workout_day = :day AND workout_month = :month AND workout_year = :year')
  Future<List<Workout>> getWorkoutsByDate(int day, int month, int year);

  @Insert()
  Future<int> addWorkout(Workout workout);

  static WorkoutDao from(BuildContext context) {
    return context.read<WorkoutDao>();
  }
}
