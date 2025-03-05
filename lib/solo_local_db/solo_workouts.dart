import 'package:flutter/material.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/models/workout.dart';

class SoloWorkouts extends WorkoutDao with ChangeNotifier {
  final WorkoutDao dao;

  SoloWorkouts(this.dao);

  @override
  Future<List<Workout>> getAllWorkouts() {
    return dao.getAllWorkouts();
  }

  @override
  Future<int> addWorkout(Workout workout) {
    notifyListeners();
    return dao.addWorkout(workout);
  }
}
