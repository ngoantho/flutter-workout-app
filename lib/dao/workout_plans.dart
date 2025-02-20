import 'package:floor/floor.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:flutter/material.dart';

@dao
abstract class WorkoutPlanDao {
  @Query('SELECT * FROM workout_plan')
  Future<List<WorkoutPlan>> getAllWorkoutPlans();

  @Query('SELECT id FROM workout_plan WHERE name = :name')
  Future<int?> getWorkoutPlanByName(String name);

  @insert
  Future<int> addWorkoutPlan(WorkoutPlan workoutPlan);

  @delete
  Future<void> deleteWorkoutPlan(WorkoutPlan workoutPlan);
}

class WorkoutPlanProvider with ChangeNotifier {
  final WorkoutPlanDao dao;

  WorkoutPlanProvider(this.dao);

  Future<List<WorkoutPlan>> getAllWorkoutPlans() {
    return dao.getAllWorkoutPlans();
  }

  Future<int?> getWorkoutPlanByName(String name) {
    return dao.getWorkoutPlanByName(name);
  }

  Future<int> addWorkoutPlan(WorkoutPlan workoutPlan) {
    notifyListeners();
    return dao.addWorkoutPlan(workoutPlan);
  }

  Future<void> deleteWorkoutPlan(WorkoutPlan workoutPlan) {
    notifyListeners();
    return dao.deleteWorkoutPlan(workoutPlan);
  }
}