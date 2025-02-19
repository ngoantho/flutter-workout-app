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

  static ExerciseResultDao from(BuildContext context) {
    return context.read<ExerciseResultDao>();
  }
}
