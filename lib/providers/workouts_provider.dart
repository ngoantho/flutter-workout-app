import 'package:flutter/material.dart';
import 'package:homework/models/workout.dart';

class WorkoutsProvider with ChangeNotifier {
  final List<Workout> workouts = [];

  add(Workout workout) {
    workouts.add(workout);
    notifyListeners();
  }
}
