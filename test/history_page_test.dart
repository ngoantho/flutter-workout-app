import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework/dao/exercise_results.dart';
import 'package:homework/enums/workout_type.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/pages/workout_history/workout_history_entry.dart';
import 'package:homework/pages/workout_history/workout_history_page.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/solo_local_db/solo_exercise_results.dart';
import 'package:homework/solo_local_db/solo_workouts.dart';
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
      "WorkoutHistoryPage shows multiple entries when there are multiple Workouts in the shared state",
      (tester) async {
    final workoutProvider = SoloWorkouts(workoutDao);
    final workout = Workout.fromDate(date: DateTime.now(), id: 1);
    final workout2 = Workout.fromDate(date: DateTime.now(), id: 2);

    final exerciseResultProvider = SoloExerciseResults(exerciseResultDao);

    await tester.pumpWidget(ChangeNotifierProvider.value(
        value: workoutProvider,
        child: ChangeNotifierProvider.value(
          value: exerciseResultProvider,
          child: MaterialApp(
            home: WorkoutHistoryPage(WorkoutType.solo),
          ),
        )));

    // expect nothing shows up
    expect(find.byType(WorkoutHistoryEntry), findsNothing);

    await workoutProvider.addWorkout(workout);
    await tester.pumpAndSettle();
    expect(find.byType(WorkoutHistoryEntry), findsOne);

    await workoutProvider.addWorkout(workout2);
    await tester.pumpAndSettle();
    expect(find.byType(WorkoutHistoryEntry), findsNWidgets(2));
  });
}
