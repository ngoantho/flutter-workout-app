import 'package:flutter/material.dart';
import 'package:homework/typedefs/output.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/pages/workout_details/workout_detail_page.dart';

class WorkoutHistoryEntry extends StatelessWidget {
  final Workout workout;

  const WorkoutHistoryEntry(this.workout, {super.key});

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
              "Workout: ${workout.date.formatMonthDayYear()}",
            ),
            // Text('Exercise Results: ${workout.results.length}'),
            // Text('Successful Results: ${workout.results.where(
            //       (exerciseResult) => isSuccessful(
            //           actual: exerciseResult.actualOutput,
            //           target: exerciseResult.targetOutput),
            //     ).length}'),
          ],
        ));
  }
}
