import 'package:flutter/material.dart';
import 'package:homework/dao/workout_plans.dart';
import 'package:homework/models/workout_plan.dart';

class WorkoutPlans extends WorkoutPlanDao with ChangeNotifier {
  final WorkoutPlanDao dao;

  WorkoutPlans(this.dao);

  @override
  Future<List<WorkoutPlan>> getAllWorkoutPlans() {
    return dao.getAllWorkoutPlans();
  }

  @override
  Future<int?> getWorkoutPlanByURL(String name) {
    return dao.getWorkoutPlanByURL(name);
  }

  @override
  Future<int> addWorkoutPlan(WorkoutPlan workoutPlan) {
    notifyListeners();
    return dao.addWorkoutPlan(workoutPlan);
  }

  @override
  Future<void> deleteWorkoutPlan(WorkoutPlan workoutPlan) {
    notifyListeners();
    return dao.deleteWorkoutPlan(workoutPlan);
  }
}
