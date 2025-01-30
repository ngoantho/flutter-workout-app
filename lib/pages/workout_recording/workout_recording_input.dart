import 'package:flutter/material.dart';
import 'package:homework/models/measurement_unit.dart';
import 'package:homework/pages/workout_recording/workout_recording_input_action.dart';

class WorkoutRecordingInput extends StatefulWidget {
  final TextEditingController actualOutputController;
  final MeasurementUnit measurementUnit;

  const WorkoutRecordingInput(this.actualOutputController, this.measurementUnit,
      {super.key});

  @override
  State<WorkoutRecordingInput> createState() => _WorkoutRecordingInputState();
}

class _WorkoutRecordingInputState extends State<WorkoutRecordingInput> {
  final focusNode = FocusNode();
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.actualOutputController,
        keyboardType: TextInputType.number,
        focusNode: focusNode,
        decoration: InputDecoration(
            labelText: 'Actual Output',
            suffix: switch (widget.measurementUnit) {
              MeasurementUnit.meters => WorkoutRecordingInputAction(
                  actualOutputController: widget.actualOutputController,
                  focusNode: focusNode,
                  values: [1, 10, 100]),
              MeasurementUnit.repetitions => WorkoutRecordingInputAction(
                  actualOutputController: widget.actualOutputController,
                  focusNode: focusNode,
                  values: [1, 5, 10]),
              MeasurementUnit.seconds => WorkoutRecordingInputAction(
                  actualOutputController: widget.actualOutputController,
                  focusNode: focusNode,
                  values: [1, 15, 30]),
            },
            suffixIcon: IconButton(
                onPressed: widget.actualOutputController.clear,
                icon: Icon(Icons.clear))),
        validator: validateOutput);
  }

  String? validateOutput(String? input) {
    if (input == null || input.isEmpty) {
      return 'Enter an output ≥ 0';
    } else if (int.parse(input) < 0) {
      return 'Output must be ≥ 0';
    }
    return null;
  }
}
