import 'package:flutter/material.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/output.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/widgets/common_scaffold.dart';

class WorkoutDetailsPage extends StatelessWidget {
  final Workout workout;

  const WorkoutDetailsPage(this.workout, {super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      ListView.separated(
          itemBuilder: (context, index) =>
              _ResultDetails(workout.results[index]),
          separatorBuilder: (context, index) => SizedBox(height: 50),
          itemCount: workout.results.length),
      title: 'Workout: ${workout.date}',
    );
  }
}

class _ResultDetails extends StatelessWidget {
  final ExerciseResult result;

  const _ResultDetails(this.result);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(result.exercise.name),
        Text('Actual Output: ${result.actualOutput}'),
        Text(isSuccessful(
                actual: result.actualOutput,
                target: result.exercise.targetOutput)
            ? 'Successful Result ✔️'
            : 'Failed Result ✖️')
      ],
    );
  }
}
