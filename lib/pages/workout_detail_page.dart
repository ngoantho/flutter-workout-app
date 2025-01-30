import 'package:flutter/material.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/output.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/widgets/center_row.dart';
import 'package:homework/widgets/common_scaffold.dart';

class WorkoutDetailsPage extends StatelessWidget {
  final Workout workout;

  const WorkoutDetailsPage(this.workout, {super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        title: 'Workout: ${workout.date}',
        content: ListView.separated(
            itemBuilder: (context, index) =>
                _ResultDetails(workout.results[index]),
            separatorBuilder: (context, index) => SizedBox(height: 50),
            itemCount: workout.results.length));
  }
}

class _ResultDetails extends StatelessWidget {
  final ExerciseResult result;

  const _ResultDetails(this.result);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Name: ${result.exercise.name}'),
        Text(
            'Target Output: ${result.exercise.targetOutput} ${result.measurementUnit}'),
        Text('Actual Output: ${result.actualOutput} ${result.measurementUnit}'),
        if (Output.isSuccessful(
            actual: result.actualOutput, target: result.targetOutput))
          CenterRow(
            children: [Text('Successful Result'), Icon(Icons.check)],
          )
        else
          CenterRow(
            children: [Text('Failed Result'), Icon(Icons.close)],
          )
      ],
    );
  }
}
