import 'package:flutter/material.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/typedefs/output.dart';

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
