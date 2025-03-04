import 'package:flutter/material.dart';
import 'package:homework/dao/workout_plans.dart';
import 'package:homework/models/workout_plan.dart';

class WorkoutPlans with ChangeNotifier {
  final WorkoutPlanDao dao;

  WorkoutPlans(this.dao);

  Future<List<WorkoutPlan>> getAllWorkoutPlans() {
    return dao.getAllWorkoutPlans();
  }

  Future<int?> getWorkoutPlanByURL(String name) {
    return dao.getWorkoutPlanByURL(name);
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
