import 'package:flutter/material.dart';
import 'package:homework/dao/exercise_results.dart';
import 'package:homework/dao/workouts.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/typedefs/output.dart';

class RecentPerformance extends StatelessWidget implements PreferredSizeWidget {
  const RecentPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: WorkoutDao.from(context).getAllWorkouts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildListTile('Loading...');
        }

        final workouts = snapshot.data!;

        final today = DateTime.now();
        final sevenDaysAgo = today.subtract(Duration(days: 7));

        final workoutsPastSevenDays = workouts.where(
          (workout) {
            final date = workout.date;
            return date.compareTo(sevenDaysAgo) >= 0 &&
                date.compareTo(today) <= 0;
          },
        ).map(
          (workout) {
            return workout.id!;
          },
        );

        final exerciseResultDao = ExerciseResultDao.from(context);
        Future<List<ExerciseResult>> future() async {
          final results = await exerciseResultDao.getAllExerciseResults();
          return results
              .where(
                  (result) => workoutsPastSevenDays.contains(result.workoutId))
              .toList();
        }

        return FutureBuilder(
          future: future(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildListTile('Loading...');
            }
            final filteredResults = snapshot.data!;

            int successful = 0;
            for (var result in filteredResults) {
              if (isSuccessful(
                  actual: result.actualOutput, target: result.targetOutput)) {
                successful += 1;
              }
            }
            return buildListTile('Successful: $successful');
          },
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget buildListTile(String s) {
    return ListTile(
      title: Text('Recent Performance over past 7 days',
          textAlign: TextAlign.center),
      subtitle: Text(s, textAlign: TextAlign.center),
    );
  }
}
