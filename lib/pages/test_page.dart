import 'package:flutter/material.dart';
import 'package:homework/providers/workout_provider.dart';
import 'package:homework/widgets/common_scaffold.dart';
import 'package:provider/provider.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<WorkoutProvider>().workouts.forEach((workout) => debugPrint(workout.toString()));
    return CommonScaffold(title: 'Test Page', content: const Placeholder());
  }
}