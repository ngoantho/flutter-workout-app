import 'package:floor/floor.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

@dao
abstract class ExerciseResultDao {
  @Query('SELECT * FROM exercise_result WHERE workout_id = :workoutId')
  Future<List<ExerciseResult>> getExerciseResultsByWorkoutId(int workoutId);

  @Query('SELECT * FROM exercise_result')
  Future<List<ExerciseResult>> getAllExerciseResults();

  @Insert()
  Future<int> addExerciseResult(ExerciseResult exerciseResult);
}

class ExerciseResultProvider with ChangeNotifier {
  final ExerciseResultDao dao;

  ExerciseResultProvider(this.dao);

  Future<List<ExerciseResult>> getExerciseResultsByWorkoutId(int workoutId) {
    return dao.getExerciseResultsByWorkoutId(workoutId);
  }

  Future<List<ExerciseResult>> getAllExerciseResults() {
    return dao.getAllExerciseResults();
  }

  Future<int> addExerciseResult(ExerciseResult exerciseResult) {
    notifyListeners();
    return dao.addExerciseResult(exerciseResult);
  }
}
