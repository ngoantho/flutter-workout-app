import 'package:floor/floor.dart';
import 'package:homework/models/workout.dart';

@dao
abstract class WorkoutDao {
  @Query('SELECT * FROM workout')
  Future<List<Workout>> getAllWorkouts();

  @Query('SELECT * FROM workout WHERE id = :id')
  Future<Workout?> getWorkoutById(int id);

  @Insert()
  Future<int> addWorkout(Workout workout);
}
