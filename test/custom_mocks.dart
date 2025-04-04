import 'package:homework/dao/exercise_results.dart';
import 'package:homework/dao/exercises.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/models/exercise.dart';
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
}

class MockExerciseResultDao extends ExerciseResultDao {
  List<ExerciseResult> results = [];

  @override
  Future<int> add(ExerciseResult exerciseResult) async {
    results.add(exerciseResult);
    return results.length;
  }

  @override
  Future<List<ExerciseResult>> getAll() async {
    return results;
  }

  @override
  Future<List<ExerciseResult>> getAllByWorkoutId(int workoutId) async {
    return results.where((result) => result.workoutId == workoutId).toList();
  }
}

class MockExerciseDao extends ExerciseDao {
  List<Exercise> exercises = [];

  @override
  Future<int> addExercise(Exercise exercise) async {
    exercises.add(exercise);
    return exercises.length;
  }

  @override
  Future<List<Exercise>> getExercisesByWorkoutPlanId(int workoutPlanId) async {
    return exercises
        .where((exercise) => exercise.workoutPlanId == workoutPlanId)
        .toList();
  }
}
