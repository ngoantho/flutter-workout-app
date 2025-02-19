import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework/dao/exercise_results.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/pages/workout_history/workout_history_entry.dart';
import 'package:homework/pages/workout_history/workout_history_page.dart';
import 'package:homework/dao/workouts.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'history_page_test.mocks.dart';

@GenerateMocks([WorkoutDao, ExerciseResultDao])
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
    final workoutProvider = WorkoutProvider(workoutDao);
    final workout = Workout.fromDate(date: DateTime.now(), id: 0);
    final workout2 = Workout.fromDate(date: DateTime.now(), id: 1);

    when(workoutDao.getAllWorkouts()).thenAnswer(
      (_) async {
        return [workout];
      },
    );

    when(workoutDao.addWorkout(workout)).thenAnswer((_) async {
      return 0;
    });

    when(workoutDao.addWorkout(workout2)).thenAnswer((_) async {
      return 1;
    });

    final exerciseResultProvider = ExerciseResultProvider(exerciseResultDao);

    when(exerciseResultDao.getAllExerciseResults()).thenAnswer((_) async {
      return [];
    });

    when(exerciseResultDao.getExerciseResultsByWorkoutId(0))
        .thenAnswer((_) async {
      return [];
    });

    when(exerciseResultDao.getExerciseResultsByWorkoutId(1))
        .thenAnswer((_) async {
      return [];
    });

    await tester.pumpWidget(ChangeNotifierProvider.value(
        value: workoutProvider,
        child: ChangeNotifierProvider.value(
          value: exerciseResultProvider,
          child: MaterialApp(
            home: WorkoutHistoryPage(),
          ),
        )));

    // expect nothing shows up
    expect(find.byType(WorkoutHistoryEntry), findsNothing);

    await workoutProvider.addWorkout(workout);
    await tester.pumpAndSettle();
    expect(find.byType(WorkoutHistoryEntry), findsOne);

    when(workoutDao.getAllWorkouts()).thenAnswer(
      (_) async {
        return [workout, workout2];
      },
    );

    await workoutProvider.addWorkout(workout2);
    await tester.pumpAndSettle();
    expect(find.byType(WorkoutHistoryEntry), findsNWidgets(2));
  });
}
