import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/pages/workout_history/workout_history_entry.dart';
import 'package:homework/pages/workout_history/workout_history_page.dart';
import 'package:homework/providers/workouts_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets(
      "WorkoutHistoryPage shows multiple entries when there are multiple Workouts in the shared state",
      (tester) async {
    final workoutsProvider = WorkoutsProvider();

    await tester.pumpWidget(ChangeNotifierProvider.value(
        value: workoutsProvider,
        child: MaterialApp(
          home: WorkoutHistoryPage(),
        )));

    // expect nothing shows up
    expect(find.byType(WorkoutHistoryEntry), findsNothing);

    workoutsProvider.add(Workout(date: DateTime.now(), results: []));
    await tester.pumpAndSettle();
    expect(find.byType(WorkoutHistoryEntry), findsOne);

    workoutsProvider.add(Workout(date: DateTime.now(), results: []));
    await tester.pumpAndSettle();
    expect(find.byType(WorkoutHistoryEntry), findsNWidgets(2));
  });
}
