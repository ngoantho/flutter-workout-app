import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework/dao/exercise_results.dart';
import 'package:homework/dao/exercises.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/enums/measurement_unit.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/pages/workout_recording/methods/minus_value_plus_method.dart';
import 'package:homework/pages/workout_recording/methods/value_dropdown_method.dart';
import 'package:homework/pages/workout_recording/workout_recording_form.dart';
import 'package:provider/provider.dart';

import 'custom_mocks.dart';

void main() {
  late WorkoutDao workoutDao;
  late ExerciseDao exerciseDao;
  late ExerciseResultDao resultDao;

  setUp(() {
    workoutDao = MockWorkoutDao();
    exerciseDao = MockExerciseDao();
    resultDao = MockExerciseResultDao();
  });

  testWidgets(
      "WorkoutRecordingPage shows a separate input for each exercise in the workout plan it's given",
      (tester) async {
    final workoutsProvider = WorkoutProvider(workoutDao);
    final workoutPlan = WorkoutPlan(name: 'Test Plan', id: 1);

    final exerciseProvider = ExerciseProvider(exerciseDao);
    exerciseProvider.addExercise(
        Exercise(name: 'seconds', target: 30, unit: seconds, workoutPlanId: 1));
    exerciseProvider.addExercise(Exercise(
        name: 'repetitions', target: 10, unit: repetitions, workoutPlanId: 1));
    exerciseProvider.addExercise(
        Exercise(name: 'meters', target: 100, unit: meters, workoutPlanId: 1));

    final resultsProvider = ExerciseResultProvider(resultDao);

    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: workoutsProvider),
          ChangeNotifierProvider.value(value: exerciseProvider),
          ChangeNotifierProvider.value(value: resultsProvider)
        ],
        child: MaterialApp(
            home: WorkoutRecordingForm(
          workoutPlan,
        ))));

    await tester.pumpAndSettle();

    expect(find.byType(ValueDropdownMethod), findsOne); // seconds
    expect(find.byType(MinusValuePlusMethod), findsOne); // repetitions
    // expect(find.byType(ValueInputMethod), findsOne); // meters
  });

  testWidgets(
      "WorkoutRecordingPage adds a Workout to the shared state when the user fills out and ends a workout",
      (tester) async {
    final workoutsProvider = WorkoutProvider(workoutDao);
    final workoutPlan = WorkoutPlan(name: "Test Plan", id: 2);

    final exerciseProvider = ExerciseProvider(exerciseDao);
    exerciseProvider.addExercise(Exercise(
        name: 'Jump 10 times',
        target: 10,
        unit: repetitions,
        workoutPlanId: 2));

    final resultsProvider = ExerciseResultProvider(resultDao);

    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: workoutsProvider),
          ChangeNotifierProvider.value(value: exerciseProvider),
          ChangeNotifierProvider.value(value: resultsProvider)
        ],
        child: MaterialApp(
            home: WorkoutRecordingForm(
          workoutPlan,
        ))));

    await tester.pumpAndSettle();

    // find validate button
    final validateBtn = find.byKey(Key('validateFormBtnKey'));
    expect(validateBtn, findsOne);

    // tap on the button
    await tester.tap(validateBtn);
    final workouts = await workoutsProvider.getAllWorkouts();
    expect(workouts, hasLength(1));
  });
}
