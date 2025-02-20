import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework/classes/exercise_result_controller.dart';
import 'package:homework/dao/exercise_results.dart';
import 'package:homework/dao/exercises.dart';
import 'package:homework/examples/sample_workout_plan.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/enums/measurement_unit.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/pages/workout_recording/methods/minus_value_plus_method.dart';
import 'package:homework/pages/workout_recording/methods/value_dropdown_method.dart';
import 'package:homework/pages/workout_recording/methods/value_input_method.dart';
import 'package:homework/pages/workout_recording/workout_recording_form.dart';
import 'package:homework/dao/workouts.dart';
import 'package:provider/provider.dart';

import 'custom_mocks.dart';

void main() {
  late MockWorkoutDao workoutDao;
  late MockExerciseDao exerciseDao;
  late MockExerciseResultDao resultDao;

  setUp(() {
    workoutDao = MockWorkoutDao();
    exerciseDao = MockExerciseDao();
    resultDao = MockExerciseResultDao();
  });

  testWidgets(
      "WorkoutRecordingPage shows a separate input for each exercise in the workout plan it's given",
      (tester) async {
    final workoutsProvider = WorkoutProvider(workoutDao);
    final workoutPlan = sampleWorkoutPlan;

    exerciseDao.exercises = sampleExercises;
    final exerciseProvider = ExerciseProvider(exerciseDao);

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

    expect(find.byType(BasePlusMinusMethod), findsNWidgets(3));
    expect(find.byType(MinusValuePlusMethod), findsNWidgets(3));
    expect(find.byType(ValueInputMethod), findsNWidgets(3));
  });

  /*
  testWidgets(
      "WorkoutRecordingPage adds a Workout to the shared state when the user fills out and ends a workout",
      (tester) async {
    final workoutsProvider = WorkoutProvider(workoutDao);
    final workoutPlan = sampleWorkoutPlan;

    final controllers = <ExerciseResultController>[
      ExerciseResultController(
          controller: TextEditingController(text: 10.toString()),
          exercise:
              Exercise(name: 'Jump 10 times', target: 10, unit: repetitions))
    ];

    await tester.pumpWidget(ChangeNotifierProvider.value(
        value: workoutsProvider,
        child: MaterialApp(
            home:
                WorkoutRecordingForm(workoutPlan, controllers: controllers))));

    // find validate button
    final validateBtn = find.byKey(Key('validateFormBtnKey'));
    expect(validateBtn, findsOne);

    // tap on the button
    await tester.tap(validateBtn);
    expect(workoutsProvider.getAllWorkouts(), hasLength(1));
  });
  */
}
