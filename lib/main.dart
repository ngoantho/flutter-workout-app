import 'package:flutter/material.dart';
// import 'package:homework/examples/sample_workout_plan.dart';
import 'package:homework/pages/workout_history/workout_history_page.dart';
// import 'package:homework/pages/workout_recording/workout_recording_page.dart';
import 'package:homework/providers/workout_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => WorkoutProvider(),
    child: const MyApp()
  ));
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
        home: WorkoutHistoryPage());
  }
}
