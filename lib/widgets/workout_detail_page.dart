import 'package:flutter/material.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/output.dart';
import 'package:homework/models/workout.dart';
import 'package:homework/widgets/common_page.dart';

class WorkoutDetailsPage extends CommonPage {
  final Workout workout;

  const WorkoutDetailsPage(this.workout, {super.key});

  @override
  Widget content(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => _ResultDetails(workout.results[index]),
        separatorBuilder: (context, index) => SizedBox(height: 50),
        itemCount: workout.results.length);
  }

  @override
  String get title => 'Workout: ${workout.dateToString()}';
}

class _ResultDetails extends StatelessWidget {
  final ExerciseResult result;

  const _ResultDetails(this.result);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Name: ${result.exercise.name}'),
        Text('Target Output: ${result.exercise.targetOutput}'),
        Text('Actual Output: ${result.actualOutput}'),
        Text(Output.isSuccessful(
                actual: result.actualOutput,
                target: result.exercise.targetOutput)
            ? 'Successful Result ✔️'
            : 'Failed Result ✖️')
      ],
    );
  }
}
