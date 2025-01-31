import 'package:flutter/material.dart';
import 'package:homework/models/exercise_result.dart';
import 'package:homework/models/output.dart';
import 'package:homework/widgets/centering/center_row.dart';

class WorkoutDetails extends StatelessWidget {
  final ExerciseResult result;

  const WorkoutDetails(this.result, {super.key});

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
