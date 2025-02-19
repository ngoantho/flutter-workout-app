import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:homework/models/workout.dart';

@dao
abstract class WorkoutDao {
  @Query('SELECT * FROM workout')
  Future<List<Workout>> getAllWorkouts();

  @Query(
      'SELECT * FROM workout WHERE workout_day = :day AND workout_month = :month AND workout_year = :year')
  Future<List<Workout>> getWorkoutsByDate(int year, int month, int day);

  @Insert()
  Future<int> addWorkout(Workout workout);
}

class WorkoutProvider with ChangeNotifier {
  final WorkoutDao dao;

  WorkoutProvider(this.dao);

  Future<List<Workout>> getAllWorkouts() {
    return dao.getAllWorkouts();
  }

  Future<List<Workout>> getWorkoutsByDate(int year, int month, int day) {
    return dao.getWorkoutsByDate(year, month, day);
  }

  Future<int> addWorkout(Workout workout) {
    notifyListeners();
    return dao.addWorkout(workout);
  }
}
