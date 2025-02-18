import 'package:flutter/material.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/widgets/common_scaffold.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/typedefs/output.dart';

class WorkoutDetailsPage extends StatelessWidget {
  final Workout workout;
  final List<ExerciseResult> results;

  const WorkoutDetailsPage(this.workout, this.results, {super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        title: 'Workout: ${workout.date.formatMonthDayYear()}',
        content: ListView.separated(
            itemBuilder: (context, index) => WorkoutDetails(results[index]),
            separatorBuilder: (context, index) => SizedBox(height: 50),
            itemCount: results.length));
  }
}

class WorkoutDetails extends StatelessWidget {
  final ExerciseResult result;

  const WorkoutDetails(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Name: ${result.exercise.name}'),
        Text(
            'Target Output: ${result.exercise.target} ${result.measurementUnit}'),
        Text('Actual Output: ${result.actualOutput} ${result.measurementUnit}'),
        if (isSuccessful(
            actual: result.actualOutput, target: result.targetOutput))
          Wrap(
            alignment: WrapAlignment.center,
            children: [Text('Successful Result'), Icon(Icons.check)],
          )
        else
          Wrap(
            alignment: WrapAlignment.center,
            children: [Text('Failed Result'), Icon(Icons.close)],
          )
      ],
    );
  }
}
