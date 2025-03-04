import 'package:flutter/material.dart';
import 'package:homework/dao/exercise_results.dart';
import 'package:homework/models/exercise_result.dart';

class ExerciseResults extends ExerciseResultDao with ChangeNotifier {
  final ExerciseResultDao dao;

  ExerciseResults(this.dao);

  @override
  Future<int> add(ExerciseResult exerciseResult) {
    notifyListeners();
    return dao.add(exerciseResult);
  }

  @override
  Future<List<ExerciseResult>> getAll() {
    return dao.getAll();
  }

  @override
  Future<List<ExerciseResult>> getAllByWorkoutId(int workoutId) {
    return dao.getAllByWorkoutId(workoutId);
  }
}