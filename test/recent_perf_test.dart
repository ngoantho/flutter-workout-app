import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/enums/measurement_unit.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/dao/exercise_results.dart';
import 'package:homework/recent_perf.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'recent_perf_test.mocks.dart';

@GenerateMocks([WorkoutDao, ExerciseResultDao])
void main() {
  testWidgets(
      "Recent Performance widget displays a metric based on the Workouts in the shared state",
      (tester) async {
    final workoutDao = MockWorkoutDao();
    final workoutsProvider = WorkoutProvider(workoutDao);
    final exerciseResultDao = MockExerciseResultDao();
    final exerciseResultProvider = ExerciseResultProvider(exerciseResultDao);

    var workout1 = Workout.fromDate(
        date: DateTime.now().subtract(Duration(days: 1)), id: 0);

    final result1 = ExerciseResult(
        exerciseName: '10 seconds',
        targetOutput: 10,
        measurementUnit: seconds,
        actualOutput: 10);

    // Ensure mocks are in place BEFORE calling addWorkout
    when(workoutDao.getAllWorkouts()).thenAnswer((_) async {
      return [workout1];
    });

    when(exerciseResultDao.getAllExerciseResults()).thenAnswer((_) async {
      return [result1];
    });

    when(exerciseResultDao.getExerciseResultsByWorkoutId(0))
        .thenAnswer((_) async {
      return [result1];
    });

    when(workoutDao.addWorkout(workout1)).thenAnswer((_) async {
      return 0;
    });

    await tester.pumpWidget(ChangeNotifierProvider.value(
        value: workoutsProvider,
        child: ChangeNotifierProvider.value(
            value: exerciseResultProvider,
            child: MaterialApp(
                home: Scaffold(
              appBar: RecentPerformance(),
            )))));

    // Act: Add a workout
    workoutsProvider.addWorkout(workout1);

    // Ensure UI rebuilds
    await tester.pumpAndSettle();

    // Assert: Verify the expected text appears
    expect(find.text('1 successful results'), findsOneWidget);
  });

  /*
    var workout2 =
        Workout(date: DateTime.now().subtract(Duration(days: 1)), results: [
      ExerciseResult(
          exerciseName: 'Row 10 meters',
          targetOutput: 10,
          measurementUnit: meters,
          actualOutput: 10),
    ]);
    workoutsProvider.add(workout2);
    await tester.pumpAndSettle();
    expect(find.text('2 successful results'), findsOne);
  });

  testWidgets(
      "Recent Performance widget displays some default message or metric when no workouts have been done in the past seven days",
      (tester) async {
    final workoutsProvider = WorkoutsProvider();

    await tester.pumpWidget(ChangeNotifierProvider.value(
        value: workoutsProvider,
        child: MaterialApp(
            home: Scaffold(
          appBar: RecentPerformance(),
        ))));

    var pastWorkout =
        Workout(date: DateTime.now().subtract(Duration(days: 8)), results: [
      ExerciseResult(
          exerciseName: '10 seconds',
          targetOutput: 10,
          measurementUnit: seconds,
          actualOutput: 10),
    ]);
    workoutsProvider.add(pastWorkout);
    await tester.pumpAndSettle();
    expect(find.text('0 successful results'), findsOne);
  });
  */
}
