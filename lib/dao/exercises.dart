import 'package:floor/floor.dart';
import 'package:homework/models/exercise.dart';

@dao
abstract class ExerciseDao {
  @Query('SELECT * FROM exercise WHERE workout_plan_id = :workoutPlanId')
  Future<List<Exercise>> getExercisesByWorkoutPlanId(int workoutPlanId);

  @insert
  Future<int> addExercise(Exercise exercise);
}
