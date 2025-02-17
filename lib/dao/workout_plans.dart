import 'package:floor/floor.dart';
import 'package:homework/models/workout_plan.dart';

@dao
abstract class WorkoutPlanDao {
  @Query('SELECT * FROM workout_plan')
  Future<List<WorkoutPlan>> getAllWorkoutPlans();

  @Query('SELECT * FROM workout_plan WHERE id = :id')
  Future<WorkoutPlan?> getWorkoutPlanById(int id);

  @Insert()
  Future<int> addWorkoutPlan(WorkoutPlan workoutPlan);
}
