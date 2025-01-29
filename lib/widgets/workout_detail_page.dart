import 'package:flutter/material.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/output.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/mixins/common_scaffold.dart';

class WorkoutDetailsPage extends StatelessWidget with CommonScaffold {
  final Workout workout;

  const WorkoutDetailsPage(this.workout, {super.key});

  @override
  Widget build(BuildContext context) {
    return scaffold(
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
        Text(Output.isSuccessful(
                actual: result.actualOutput,
                target: result.exercise.targetOutput)
            ? 'Successful Result ✔️'
            : 'Failed Result ✖️')
      ],
    );
  }
}
