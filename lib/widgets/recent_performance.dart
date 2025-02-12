import 'package:flutter/material.dart';
import 'package:homework/models/output.dart';
import 'package:homework/providers/workouts_provider.dart';
import 'package:provider/provider.dart';

class RecentPerformance extends StatelessWidget implements PreferredSizeWidget {
  const RecentPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final sevenDaysAgo = today.subtract(Duration(days: 7));
    final workouts = context.watch<WorkoutsProvider>().workouts;

    final workoutsPastSevenDays = workouts.where(
      (workout) {
        final date = workout.date;
        return date.compareTo(sevenDaysAgo) >= 0 && date.compareTo(today) <= 0;
      },
    );

    int successful = 0;
    for (var workout in workoutsPastSevenDays) {
      successful += workout.results
          .where(
            (exerciseResult) => Output.isSuccessful(
                actual: exerciseResult.actualOutput,
                target: exerciseResult.targetOutput),
          )
          .length;
    }

    return ListTile(
        title: Text(
          'Recent Performance over past 7 days',
          textAlign: TextAlign.center,
        ),
        subtitle: Text(
          '$successful successful results',
          textAlign: TextAlign.center,
        ));
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
