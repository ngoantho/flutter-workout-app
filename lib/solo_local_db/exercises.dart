import 'package:flutter/material.dart';
import 'package:homework/dao/exercises.dart';
import 'package:homework/models/exercise.dart';

class Exercises extends ExerciseDao with ChangeNotifier {
  final ExerciseDao dao;

  Exercises(this.dao);

  @override
  Future<List<Exercise>> getExercisesByWorkoutPlanId(int workoutPlanId) {
    return dao.getExercisesByWorkoutPlanId(workoutPlanId);
  }

  @override
  Future<int> addExercise(Exercise exercise) {
    notifyListeners();
    return dao.addExercise(exercise);
  }

  @override
  Future<void> deleteExercise(Exercise exercise) {
    notifyListeners();
    return dao.deleteExercise(exercise);
  }
}
