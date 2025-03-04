import 'package:flutter/material.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/models/workout.dart';

class Workouts with ChangeNotifier {
  final WorkoutDao dao;

  Workouts(this.dao);

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
