import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/measurement_unit.dart';
import 'package:homework/models/output.dart';
import 'package:homework/pages/workout_details/workout_result_details.dart';

void main() {
  group(
      "WorkoutDetails shows specifics of which exercises were done and what the actual output was while doing those exercises",
      () {
    testWidgets("Successful Result", (tester) async {
      var passingExerciseResult = ExerciseResult(
          exercise: Exercise(
              name: 'Run 100 meters', target: Output(100), unit: meters),
          actualOutput: Output(100));

      await tester
          .pumpWidget(MaterialApp(home: WorkoutDetails(passingExerciseResult)));

      expect(find.text('Name: Run 100 meters'), findsOne);
      expect(find.text('Target Output: 100 meters'), findsOne);
      expect(find.text('Actual Output: 100 meters'), findsOne);
      expect(find.textContaining('Successful Result'), findsOne);
    });

    testWidgets("Failed Result", (tester) async {
      var passingExerciseResult = ExerciseResult(
          exercise: Exercise(
              name: 'Jump 10 times', target: Output(10), unit: repetitions),
          actualOutput: Output(5));

      await tester
          .pumpWidget(MaterialApp(home: WorkoutDetails(passingExerciseResult)));

      expect(find.text('Name: Jump 10 times'), findsOne);
      expect(find.text('Target Output: 10 repetitions'), findsOne);
      expect(find.text('Actual Output: 5 repetitions'), findsOne);
      expect(find.textContaining('Failed Result'), findsOne);
    });
  });
}
