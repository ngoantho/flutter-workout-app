import 'package:flutter/material.dart';
import 'package:homework/dao/workouts.dart';

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

        if (snapshot.hasError) {
          return buildListTile('Error: ${snapshot.error}');
        }

        final workouts = snapshot.data;
        return buildListTile('Workouts: ${workouts?.length}');
      },
    );

    /*
    final today = DateTime.now();
    final sevenDaysAgo = today.subtract(Duration(days: 7));

    /*
    final workoutsPastSevenDays = workouts.where(
      (workout) {
        final date = workout.date;
        return date.compareTo(sevenDaysAgo) >= 0 && date.compareTo(today) <= 0;
      },
    );
    */

    int successful = 0;
    /*
    for (var workout in workoutsPastSevenDays) {
      // successful += workout.results
      //     .where(
      //       (exerciseResult) => isSuccessful(
      //           actual: exerciseResult.actualOutput,
      //           target: exerciseResult.targetOutput),
      //     )
      //     .length;
    }
    */

    return ListTile(
        title: Text(
          'Recent Performance over past 7 days',
          textAlign: TextAlign.center,
        ),
        subtitle: Text(
          '$successful successful results',
          textAlign: TextAlign.center,
        ));
    */
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
