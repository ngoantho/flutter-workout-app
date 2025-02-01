import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework/classes/exercise_result_controller.dart';
import 'package:homework/examples/sample_workout_plan.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/measurement_unit.dart';
import 'package:homework/models/output.dart';
import 'package:homework/pages/workout_recording/methods/base_plus_minus_method.dart';
import 'package:homework/pages/workout_recording/methods/minus_value_plus_method.dart';
import 'package:homework/pages/workout_recording/methods/value_input_method.dart';
import 'package:homework/pages/workout_recording/workout_recording_page.dart';
import 'package:homework/providers/workouts_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets(
      "WorkoutRecordingPage shows a separate input for each exercise in the workout plan it's given",
      (tester) async {
    final workoutsProvider = WorkoutsProvider();
    final workoutPlan = sampleWorkoutPlan;

    final controllers = <ExerciseResultController>[
      ExerciseResultController(
        exercise: Exercise(
            name: 'Jump 10 times',
            targetOutput: Output(10),
            measurementUnit: repetitions),
        controller: TextEditingController(text: ''),
      ),
      ExerciseResultController(
          exercise: Exercise(
              name: 'Run 100 meters',
              targetOutput: Output(100),
              measurementUnit: meters),
          controller: TextEditingController(text: '')),
      ExerciseResultController(
          exercise: Exercise(
              name: 'Hold breath for 15 seconds',
              targetOutput: Output(15),
              measurementUnit: seconds),
          controller: TextEditingController(text: ''))
    ];

    await tester.pumpWidget(ChangeNotifierProvider.value(
        value: workoutsProvider,
        child: MaterialApp(
            home: WorkoutRecordingPage(
          workoutPlan,
          controllers: controllers,
        ))));

    expect(find.byType(BasePlusMinusMethod), findsOne);
    expect(find.byType(MinusValuePlusMethod), findsOne);
    expect(find.byType(ValueInputMethod), findsOne);
  });

  testWidgets(
      "WorkoutRecordingPage adds a Workout to the shared state when the user fills out and ends a workout",
      (tester) async {
    final workoutsProvider = WorkoutsProvider();
    final workoutPlan = sampleWorkoutPlan;

    final controllers = <ExerciseResultController>[
      ExerciseResultController(
          controller: TextEditingController(text: Output(10).toString()),
          exercise: Exercise(
              name: 'Jump 10 times',
              targetOutput: Output(10),
              measurementUnit: repetitions))
    ];

    await tester.pumpWidget(ChangeNotifierProvider.value(
        value: workoutsProvider,
        child: MaterialApp(
            home:
                WorkoutRecordingPage(workoutPlan, controllers: controllers))));

    // find validate button
    final validateBtn = find.byKey(Key('validateFormBtnKey'));
    expect(validateBtn, findsOne);

    // tap on the button
    await tester.tap(validateBtn);
    expect(workoutsProvider.workouts, hasLength(1));
  });
}
