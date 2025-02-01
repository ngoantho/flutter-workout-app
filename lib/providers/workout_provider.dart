import 'package:flutter/material.dart';
import 'package:homework/models/workout.dart';

class WorkoutProvider with ChangeNotifier {
  final List<Workout> workouts = [];

  add(Workout workout) {
    workouts.add(workout);
    notifyListeners();
  }
}