import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/measurement_unit.dart';
import 'package:homework/models/output.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/pages/workout_history/workout_history_page.dart';
import 'package:homework/providers/workout_list_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets(
      "WorkoutDetails shows specifics of which exercises were done and what the actual output was while doing those exercises",
      (tester) async {
    final workoutProvider = WorkoutListProvider();
    
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: workoutProvider,
        child: MaterialApp(home: WorkoutHistoryPage(),)
      )
    );

    workoutProvider.add(Workout(date: DateTime.now(), results: [
      ExerciseResult(
        exercise: Exercise(name: '100 meters', targetOutput: Output(100), measurementUnit: meters),
        actualOutput: Output(100)
      ),
      ExerciseResult(
        exercise: Exercise(name: '10 jumps', targetOutput: Output(10), measurementUnit: repetitions),
        actualOutput: Output(5)
      )
    ]));
    await tester.pumpAndSettle();

    final btnFinder = find.byType(ElevatedButton);
    expect(btnFinder, findsOne); // verify
    await tester.tap(btnFinder);

    expect(find.text('Name: 100 meters'), findsOne);
  });
}
