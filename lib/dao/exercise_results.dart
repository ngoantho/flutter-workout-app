import 'package:floor/floor.dart';
import 'package:homework/models/exercise_result.dart';

@dao
abstract class ExerciseResultDao {
  @Query('SELECT * FROM exercise_result WHERE workout_id = :workoutId')
  Future<List<ExerciseResult>> getExerciseResultsByWorkoutId(int workoutId);

  @Insert()
  Future<int> addExerciseResult(ExerciseResult exerciseResult);
}
