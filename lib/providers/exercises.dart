import 'package:flutter/material.dart';
import 'package:homework/dao/exercises.dart';
import 'package:homework/models/exercise.dart';

class Exercises with ChangeNotifier {
  final ExerciseDao dao;

  Exercises(this.dao);

  Future<List<Exercise>> getExercisesByWorkoutPlanId(int workoutPlanId) {
    return dao.getExercisesByWorkoutPlanId(workoutPlanId);
  }

  Future<int> addExercise(Exercise exercise) {
    notifyListeners();
    return dao.addExercise(exercise);
  }

  Future<void> deleteExercise(Exercise exercise) {
    notifyListeners();
    return dao.deleteExercise(exercise);
  }
}
