import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:homework/firebase/firebase_results.dart';
import 'package:homework/solo_local_db/exercises.dart';
import 'package:homework/solo_local_db/local_db.dart';
import 'package:homework/solo_local_db/solo_exercise_results.dart';
import 'package:homework/solo_local_db/solo_workouts.dart';
import 'package:homework/solo_local_db/workout_plans.dart';
import 'package:homework/start_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'firebase/firebase_workouts.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb && (Platform.isWindows)) {
    await windowManager.ensureInitialized();

    final windowSize = Size(480, 900);
    final windowOptions = WindowOptions(
        size: windowSize,
        minimumSize: windowSize,
        maximumSize: windowSize,
        center: true);

    await windowManager.waitUntilReadyToShow(windowOptions);
    await windowManager.show();
    await windowManager.focus();
  }

  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final localDbProviders = [
    ChangeNotifierProvider(create: (_) => SoloWorkouts(database.workoutDao)),
    ChangeNotifierProvider(
      create: (_) => SoloExerciseResults(database.exerciseResultDao),
    ),
    ChangeNotifierProvider(
        create: (_) => WorkoutPlans(database.workoutPlanDao)),
    ChangeNotifierProvider(create: (_) => Exercises(database.exerciseDao)),
  ];

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final firebaseProviders = [
    ChangeNotifierProvider(create: (_) => FirebaseWorkouts()),
    ChangeNotifierProvider(create: (_) => FirebaseResults())
  ];

  runApp(MultiProvider(
      providers: [...localDbProviders, ...firebaseProviders],
      child: const MyApp()));
}

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
          colorSchemeSeed:
              ColorScheme.fromSeed(seedColor: Colors.indigo).primary,
          useMaterial3: true,
          brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: StartSignIn(),
    );
  }
}
