import 'package:flutter/material.dart';
import 'package:homework/local_db/exercise_results.dart';
import 'package:homework/local_db/workouts.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/typedefs/output.dart';
import 'package:provider/provider.dart';

class RecentPerformance extends StatelessWidget {
  final Widget? top;

  const RecentPerformance({super.key, this.top});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<Workouts>().getAllWorkouts(),
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

        final exerciseResultDao = context.watch<ExerciseResults>();
        Future<List<ExerciseResult>> future() async {
          final results = await exerciseResultDao.getAll();
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

  Widget buildListTile(String s) {
    return ListTile(
      title: top,
      subtitle: ListTile(
        title: Text(
          'Recent Performance',
          textAlign: TextAlign.center,
        ),
        subtitle: Text(
          'Past 7 days • $s',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
