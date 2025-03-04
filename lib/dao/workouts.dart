import 'package:floor/floor.dart';
import 'package:homework/models/workout.dart';

@dao
abstract class WorkoutDao {
  @Query('SELECT * FROM workout')
  Future<List<Workout>> getAllWorkouts();

  @Query(
      'SELECT * FROM workout WHERE workout_day = :day AND workout_month = :month AND workout_year = :year')
  Future<List<Workout>> getWorkoutsByDate(int year, int month, int day);

  @Insert()
  Future<int> addWorkout(Workout workout);
}
