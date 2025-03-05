import 'package:flutter/material.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/models/workout.dart';

class FirebaseWorkouts extends WorkoutDao with ChangeNotifier {
  String db;

  FirebaseWorkouts({required this.db});

  @override
  Future<int> addWorkout(Workout workout) {
    // TODO: implement addWorkout
    throw UnimplementedError();
  }

  @override
  Future<List<Workout>> getAllWorkouts() {
    // TODO: implement getAllWorkouts
    throw UnimplementedError();
  }
}
