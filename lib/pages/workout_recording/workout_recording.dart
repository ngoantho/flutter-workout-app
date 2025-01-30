import 'package:flutter/material.dart';
import 'package:homework/mixins/readonly_textfield.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/pages/workout_recording/workout_recording_input.dart';

class WorkoutRecording extends StatefulWidget {
  final Exercise exercise;
  final TextEditingController actualOutputController;

  const WorkoutRecording(this.exercise, this.actualOutputController,
      {super.key});

  @override
  State<WorkoutRecording> createState() => _WorkoutRecordingState();
}

class _WorkoutRecordingState extends State<WorkoutRecording>
    with ReadonlyTextFieldMixin {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Row(
          children: [
            Expanded(
                child: readOnlyTextField(
                    labelText: 'Exercise', value: widget.exercise.name)),
            SizedBox(
                width: 50,
                child: readOnlyTextField(
                    labelText: 'Target',
                    value: widget.exercise.targetOutput.toString())),
            SizedBox(
                width: 100,
                child: readOnlyTextField(
                    labelText: 'Unit',
                    value: widget.exercise.measurementUnit.name))
          ],
        ),
        subtitle: WorkoutRecordingInput(
            widget.actualOutputController, widget.exercise.measurementUnit));
  }
}
