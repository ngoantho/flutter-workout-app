import 'package:flutter/material.dart';
import 'package:homework/dao/exercise_results.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/pages/workout_details/workout_detail_page.dart';
import 'package:homework/typedefs/output.dart';

class WorkoutHistoryEntry extends StatelessWidget {
  final Workout workout;

  const WorkoutHistoryEntry(this.workout, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: workout.results(ExerciseResultDao.from(context)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final results = snapshot.data!;
        return ElevatedButton(
            onPressed: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          WorkoutDetailsPage(workout, results)))
                },
            child: Column(
              children: [
                Text(
                  "Workout: ${workout.date.formatMonthDayYear()}",
                ),
                Text('Exercise Results: ${results.length}'),
                Text('Successful Results: ${results.where(
                      (exerciseResult) => isSuccessful(
                          actual: exerciseResult.actualOutput,
                          target: exerciseResult.targetOutput),
                    ).length}'),
              ],
            ));
      },
    );
  }
}
