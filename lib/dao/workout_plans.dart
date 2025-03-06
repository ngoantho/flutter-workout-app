import 'package:floor/floor.dart';
import 'package:homework/models/workout_plan.dart';

@dao
abstract class WorkoutPlanDao {
  @Query('SELECT * FROM workout_plan')
  Future<List<WorkoutPlan>> getAllWorkoutPlans();

  @Query('SELECT id FROM workout_plan WHERE url = :url')
  Future<int?> getWorkoutPlanByURL(String url);

  @insert
  Future<int> addWorkoutPlan(WorkoutPlan workoutPlan);
}
