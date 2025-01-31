import 'package:flutter/material.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/pages/workout_history/workout_history_entry.dart';
import 'package:homework/widgets/common_scaffold.dart';

class WorkoutHistoryPage extends StatelessWidget {
  final List<Workout> workouts;

  const WorkoutHistoryPage(this.workouts, {super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        title: 'Workout History',
        content: ListView.separated(
          itemCount: workouts.length,
          itemBuilder: (context, index) =>
              WorkoutHistoryEntry(workouts[index]),
          separatorBuilder: (context, index) => SizedBox(
            height: 50,
          ),
        ));
  }
}
