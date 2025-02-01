import 'package:flutter/material.dart';
import 'package:homework/models/output.dart';
import 'package:homework/providers/workout_provider.dart';
import 'package:homework/widgets/centering/center_text.dart';
import 'package:homework/widgets/sized_box/sized_box_with_width.dart';
import 'package:provider/provider.dart';

class RecentPerformance extends StatelessWidget {
  const RecentPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final sevenDaysAgo = today.subtract(Duration(days: 7));
    final workouts = context.watch<WorkoutProvider>().workouts;

    final workoutsPastSevenDays = workouts.where((workout) {
      final date = workout.date;
      return date.compareTo(sevenDaysAgo) >= 0 && date.compareTo(today) <= 0;
    },);

    int successful = 0;
    int totalResults = 0;
    for (var workout in workoutsPastSevenDays) {
      successful += workout.results.where(
                  (exerciseResult) => Output.isSuccessful(
                      actual: exerciseResult.actualOutput,
                      target: exerciseResult.targetOutput),
                ).length;
      totalResults += workout.results.length;
    }

    return BottomAppBar(child:
      ListTile(
        title: Text('Recent Performance of exercise results over past 7 days', textAlign: TextAlign.center,),
        subtitle: Text('$successful/$totalResults successful results', textAlign: TextAlign.center,)
      )
    );
  }
}