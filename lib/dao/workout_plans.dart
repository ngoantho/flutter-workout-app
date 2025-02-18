import 'package:floor/floor.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:provider/provider.dart';
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

  static WorkoutPlanDao from(BuildContext context) {
    return context.read<WorkoutPlanDao>();
  }
}
