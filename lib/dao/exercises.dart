import 'package:floor/floor.dart';
import 'package:homework/models/exercise.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

@dao
abstract class ExerciseDao {
  @Query('SELECT * FROM exercise WHERE workout_plan_id = :workoutPlanId')
  Future<List<Exercise>> getExercisesByWorkoutPlanId(int workoutPlanId);

  @insert
  Future<int> addExercise(Exercise exercise);

  @delete
  Future<void> deleteExercise(Exercise exercise);
}

class ExerciseProvider with ChangeNotifier {
  final ExerciseDao dao;

  ExerciseProvider(this.dao);

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