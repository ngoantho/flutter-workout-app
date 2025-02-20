import 'package:homework/dao/exercise_results.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/workout.dart';

class MockWorkoutDao extends WorkoutDao {
  List<Workout> workouts = [];

  @override
  Future<int> addWorkout(Workout workout) async {
    workouts.add(workout);
    return workouts.length;
  }

  @override
  Future<List<Workout>> getAllWorkouts() async {
    return workouts;
  }

  @override
  Future<List<Workout>> getWorkoutsByDate(int year, int month, int day) async {
    return workouts
        .where(
          (workout) =>
              workout.workoutYear == year &&
              workout.workoutMonth == month &&
              workout.workoutDay == day,
        )
        .toList();
  }
}

class MockExerciseResultDao extends ExerciseResultDao {
  List<ExerciseResult> results = [];

  @override
  Future<int> addExerciseResult(ExerciseResult exerciseResult) async {
    results.add(exerciseResult);
    return results.length;
  }

  @override
  Future<List<ExerciseResult>> getAllExerciseResults() async {
    return results;
  }

  @override
  Future<List<ExerciseResult>> getExerciseResultsByWorkoutId(
      int workoutId) async {
    return results.where((result) => result.workoutId == workoutId).toList();
  }
}
