import 'package:flutter/material.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/measurement_unit.dart';
import 'package:homework/models/output.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/pages/workout_details/workout_detail_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework/pages/workout_details/workout_result_details.dart';

void main() {
  testWidgets(
      "WorkoutDetails shows specifics of which exercises were done and what the actual output was while doing those exercises",
      (tester) async {
    final workout = Workout(date: DateTime.now(), results: []);
    await tester.pumpWidget(MaterialApp(home: WorkoutDetailsPage(workout)));
  });
}
