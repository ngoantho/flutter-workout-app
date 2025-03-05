import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework/dao/exercise_results.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/enums/measurement_unit.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/solo_local_db/solo_exercise_results.dart';
import 'package:homework/solo_local_db/solo_workouts.dart';
import 'package:homework/utils/recent_perf.dart';
import 'package:provider/provider.dart';

import 'custom_mocks.dart';

void main() {
  late WorkoutDao workoutDao;
  late ExerciseResultDao exerciseResultDao;

  setUp(() {
    workoutDao = MockWorkoutDao();
    exerciseResultDao = MockExerciseResultDao();
  });

  testWidgets(
      "Recent Performance widget displays a metric based on the Workouts in the shared state",
      (tester) async {
    final workoutsProvider = SoloWorkouts(workoutDao);
    final exerciseResultProvider = SoloExerciseResults(exerciseResultDao);

    var workout1 = Workout.fromDate(
        date: DateTime.now().subtract(Duration(days: 1)), id: 1);

    final result1 = ExerciseResult(
        exerciseName: '10 seconds',
        targetOutput: 10,
        measurementUnit: seconds,
        actualOutput: 10,
        workoutId: 1);

    await tester.pumpWidget(ChangeNotifierProvider.value(
        value: workoutsProvider,
        child: ChangeNotifierProvider.value(
            value: exerciseResultProvider,
            child: MaterialApp(
                home: Scaffold(
              bottomNavigationBar: RecentPerformance(),
            )))));

    // Act: Add a workout
    workoutsProvider.addWorkout(workout1);
    exerciseResultProvider.add(result1);

    // Ensure UI rebuilds
    await tester.pumpAndSettle();

    // Assert: Verify the expected text appears
    expect(find.textContaining('Successful: 1'), findsOneWidget);

    var workout2 = Workout.fromDate(
        date: DateTime.now().subtract(Duration(days: 1)), id: 2);
    final result2 = ExerciseResult(
        exerciseName: 'Row 10 meters',
        targetOutput: 10,
        measurementUnit: meters,
        actualOutput: 10,
        workoutId: 2);

    workoutsProvider.addWorkout(workout2);
    exerciseResultProvider.add(result2);

    await tester.pumpAndSettle();

    expect(find.textContaining('Successful: 2'), findsOne);
  });

  testWidgets(
      "Recent Performance widget displays some default message or metric when no workouts have been done in the past seven days",
      (tester) async {
    final workoutsProvider = SoloWorkouts(workoutDao);
    final resultsProvider = SoloExerciseResults(exerciseResultDao);

    await tester.pumpWidget(ChangeNotifierProvider.value(
        value: workoutsProvider,
        child: ChangeNotifierProvider.value(
            value: resultsProvider,
            child: MaterialApp(
                home: Scaffold(
              bottomNavigationBar: RecentPerformance(),
            )))));

    var pastWorkout = Workout.fromDate(
        date: DateTime.now().subtract(Duration(days: 8)), id: 1);
    var pastResult = ExerciseResult(
        exerciseName: '10 seconds',
        targetOutput: 10,
        measurementUnit: seconds,
        actualOutput: 10,
        workoutId: 1);

    workoutsProvider.addWorkout(pastWorkout);
    resultsProvider.add(pastResult);

    await tester.pumpAndSettle();
    expect(find.textContaining('Successful: 0'), findsOne);
  });
}
