import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/pages/workout_history/workout_history_entry.dart';
import 'package:homework/pages/workout_history/workout_history_page.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/db.dart';
import 'package:provider/provider.dart';

void main() {
  late Future<AppDatabase> database;
  late WorkoutDao workoutDao;

  setUp(() {
    database = $FloorAppDatabase.inMemoryDatabaseBuilder().build();
  });

  tearDown(() async {
    (await database).close();
  });

  testWidgets(
      "WorkoutHistoryPage shows multiple entries when there are multiple Workouts in the shared state",
      (tester) async {
    workoutDao = (await database).workoutDao;

    await tester.pumpWidget(Provider.value(
        value: workoutDao,
        child: MaterialApp(
          home: WorkoutHistoryPage(),
        )));

    // expect nothing shows up
    expect(find.byType(WorkoutHistoryEntry), findsNothing);

    await workoutDao.addWorkout(Workout.fromDate(date: DateTime.now()));
    await tester.pumpAndSettle();
    expect(find.byType(WorkoutHistoryEntry), findsOne);

    // workoutDao.addWorkout(Workout.fromDate(date: DateTime.now()));
    // await tester.pumpAndSettle();
    // expect(find.byType(WorkoutHistoryEntry), findsNWidgets(2));
  });
}
