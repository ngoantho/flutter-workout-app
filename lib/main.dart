import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:homework/dao/exercise_results.dart';
import 'package:homework/dao/exercises.dart';
import 'package:homework/dao/workout_plans.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/db.dart';
import 'package:homework/pages/workout_history/workout_history_page.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb && (Platform.isWindows)) {
    await windowManager.ensureInitialized();

    final windowSize = Size(480, 900);
    final windowOptions = WindowOptions(
        size: windowSize, minimumSize: windowSize, maximumSize: windowSize);

    await windowManager.waitUntilReadyToShow(windowOptions);
    await windowManager.show();
    await windowManager.focus();
  }

  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => WorkoutProvider(database.workoutDao)),
    ChangeNotifierProvider(
      create: (_) => ExerciseResultProvider(database.exerciseResultDao),
    ),
    ChangeNotifierProvider(
        create: (_) => WorkoutPlanProvider(database.workoutPlanDao)),
    ChangeNotifierProvider(
        create: (_) => ExerciseProvider(database.exerciseDao)),
  ], child: const MyApp()));
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
        routes: {'/': (context) => WorkoutHistoryPage()},
        initialRoute: '/');
  }
}
