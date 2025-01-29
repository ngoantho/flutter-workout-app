import 'package:flutter/material.dart';
import 'package:homework/widgets/workout_history_page.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/measurement_unit.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/models/workout_plan.dart';

void main() {
  runApp(const MyApp());
}

final sampleWorkouts = [
  Workout(date: DateTime(2024, 1, 17), results: [
    ExerciseResult(
        exercise: Exercise(
            name: "Run 200 meters",
            targetOutput: 200,
            measurementUnit: MeasurementUnit.meters),
        actualOutput: 100),
        ExerciseResult(
        exercise: Exercise(
            name: "Run 100 meters",
            targetOutput: 100,
            measurementUnit: MeasurementUnit.meters),
        actualOutput: 200),
  ]),
  Workout(date: DateTime(2024, 1, 17), results: [
    ExerciseResult(
        exercise: Exercise(
            name: "Do 20 pushups",
            targetOutput: 20,
            measurementUnit: MeasurementUnit.repetitions),
        actualOutput: 25)
  ])
];

final sampleWorkoutPlan = WorkoutPlan(name: 'February 2025', exercises: [
  Exercise(
      name: 'Run 100 meters',
      targetOutput: 100,
      measurementUnit: MeasurementUnit.meters),
  Exercise(
      name: 'Run 200 meters',
      targetOutput: 200,
      measurementUnit: MeasurementUnit.meters),
  Exercise(
      name: 'Run 400 meters',
      targetOutput: 400,
      measurementUnit: MeasurementUnit.meters),
  Exercise(
    name: 'Squat for 15 seconds',
    targetOutput: 15,
    measurementUnit: MeasurementUnit.seconds,
  ),
  Exercise(
    name: 'Squat for 30 seconds',
    targetOutput: 30,
    measurementUnit: MeasurementUnit.seconds,
  ),
  Exercise(
    name: 'Squat for 60 seconds',
    targetOutput: 60,
    measurementUnit: MeasurementUnit.seconds,
  ),
  Exercise(
    name: 'Do 10 pushups',
    targetOutput: 10,
    measurementUnit: MeasurementUnit.repetitions,
  ),
  Exercise(
    name: 'Do 20 pushups',
    targetOutput: 20,
    measurementUnit: MeasurementUnit.repetitions,
  ),
  Exercise(
    name: 'Do 30 pushups',
    targetOutput: 30,
    measurementUnit: MeasurementUnit.repetitions,
  ),
]);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homework',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorSchemeSeed: ColorScheme.fromSeed(seedColor: Colors.indigo).primary,
        useMaterial3: true,
        brightness: Brightness.dark
      ),
      debugShowCheckedModeBanner: false,
      home: WorkoutHistoryPage(sampleWorkouts)
    );
  }
}
