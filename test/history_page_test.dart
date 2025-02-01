import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/pages/workout_history/workout_history_entry.dart';
import 'package:homework/pages/workout_history/workout_history_page.dart';
import 'package:homework/providers/workout_list_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets("WorkoutHistoryPage shows multiple entries when there are multiple Workouts in the shared state", (tester) async {
    final workoutProvider = WorkoutListProvider();
    
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: workoutProvider,
        child: MaterialApp(home: WorkoutHistoryPage(),)
      )
    );

    // expect nothing shows up
    expect(find.byType(WorkoutHistoryEntry), findsNothing);

    workoutProvider.add(Workout(date: DateTime.now(), results: []));
    await tester.pumpAndSettle();
    expect(find.byType(WorkoutHistoryEntry), findsOne);

    workoutProvider.add(Workout(date: DateTime.now(), results: []));
    await tester.pumpAndSettle();
    expect(find.byType(WorkoutHistoryEntry), findsNWidgets(2));
  });
}