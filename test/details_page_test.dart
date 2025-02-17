import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/enums/measurement_unit.dart';
import 'package:homework/pages/workout_details/workout_result_details.dart';

void main() {
  group(
      "WorkoutDetails shows specifics of which exercises were done and what the actual output was while doing those exercises",
      () {
    testWidgets("Successful Result", (tester) async {
      var passingExerciseResult = ExerciseResult(
          exerciseName: 'Run 100 meters',
          targetOutput: 100,
          measurementUnit: meters,
          actualOutput: 100);

      await tester
          .pumpWidget(MaterialApp(home: WorkoutDetails(passingExerciseResult)));

      expect(find.text('Name: Run 100 meters'), findsOne);
      expect(find.text('Target Output: 100 meters'), findsOne);
      expect(find.text('Actual Output: 100 meters'), findsOne);
      expect(find.textContaining('Successful Result'), findsOne);
    });

    testWidgets("Failed Result", (tester) async {
      var passingExerciseResult = ExerciseResult(
          exerciseName: 'Jump 10 times',
          targetOutput: 10,
          measurementUnit: repetitions,
          actualOutput: 5);

      await tester
          .pumpWidget(MaterialApp(home: WorkoutDetails(passingExerciseResult)));

      expect(find.text('Name: Jump 10 times'), findsOne);
      expect(find.text('Target Output: 10 repetitions'), findsOne);
      expect(find.text('Actual Output: 5 repetitions'), findsOne);
      expect(find.textContaining('Failed Result'), findsOne);
    });
  });
}
