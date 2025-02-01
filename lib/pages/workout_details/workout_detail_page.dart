import 'package:flutter/material.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/pages/workout_details/workout_result_details.dart';
import 'package:homework/widgets/common_scaffold.dart';

class WorkoutDetailsPage extends StatelessWidget {
  final Workout workout;

  const WorkoutDetailsPage(this.workout, {super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        title: 'Workout: ${workout.date.formatMonthDayYear()}',
        content: ListView.separated(
            itemBuilder: (context, index) =>
                WorkoutDetails(workout.results[index]),
            separatorBuilder: (context, index) => SizedBox(height: 50),
            itemCount: workout.results.length));
  }
}
