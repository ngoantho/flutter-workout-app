import 'package:floor/floor.dart';
import 'package:homework/models/workout.dart';

@dao
abstract class WorkoutDao {
  @Query('SELECT * FROM workout')
  Future<List<Workout>> getAllWorkouts();

  @Insert()
  Future<int> addWorkout(Workout workout);
}
