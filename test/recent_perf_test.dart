import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/enums/measurement_unit.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/widgets/recent_performance.dart';
import 'package:provider/provider.dart';

void main() {
  /*
  testWidgets(
      "Recent Performance widget displays a metric based on the Workouts in the shared state",
      (tester) async {
    final workoutsProvider = WorkoutsProvider();

    await tester.pumpWidget(ChangeNotifierProvider.value(
        value: workoutsProvider,
        child: MaterialApp(
            home: Scaffold(
          appBar: RecentPerformance(),
        ))));

    var workout1 =
        Workout(date: DateTime.now().subtract(Duration(days: 1)), results: [
      ExerciseResult(
          exerciseName: '10 seconds',
          targetOutput: 10,
          measurementUnit: seconds,
          actualOutput: 10),
    ]);

    workoutsProvider.add(workout1);
    await tester.pumpAndSettle();
    expect(find.text('1 successful results'), findsOne);

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
