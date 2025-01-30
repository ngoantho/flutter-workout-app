import 'package:flutter/material.dart';
import 'package:homework/models/output.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/widgets/common_scaffold.dart';
import 'package:homework/pages/workout_detail_page.dart';

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
              _WorkoutHistoryEntry(workouts[index]),
          separatorBuilder: (context, index) => SizedBox(
            height: 50,
          ),
        ));
  }
}

class _WorkoutHistoryEntry extends StatelessWidget {
  final Workout workout;

  const _WorkoutHistoryEntry(this.workout);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WorkoutDetailsPage(workout)))
            },
        child: Column(
          children: [
            Text(
              "Workout: ${workout.date}",
            ),
            Text('Exercise Results: ${workout.results.length}'),
            Text('Successful Results: ${workout.results.where(
                  (exerciseResult) => Output.isSuccessful(
                      actual: exerciseResult.actualOutput,
                      target: exerciseResult.targetOutput),
                ).length}'),
          ],
        ));
  }
}
