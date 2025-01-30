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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
                controller: widget.actualOutputController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Actual Output',
                    suffixIcon: IconButton(
                        onPressed: widget.actualOutputController.clear,
                        icon: Icon(Icons.clear))),
                validator: validateOutput)),
        switch (widget.measurementUnit) {
          MeasurementUnit.meters => Wrap(
              children: ['-100', '-10', '-1', '+1', '+10', '+100']
                  .map((action) => WorkoutRecordingInputAction(
                      actualOutputController: widget.actualOutputController,
                      action: action))
                  .toList()),
          MeasurementUnit.repetitions => Wrap(
              children: ['-10', '-5', '-1', '+1', '+5', '+10']
                  .map((action) => WorkoutRecordingInputAction(
                      actualOutputController: widget.actualOutputController,
                      action: action))
                  .toList()),
          MeasurementUnit.seconds => Wrap(
              children: ['-30', '-15', '-1', '+1', '+15', '+30']
                  .map((action) => WorkoutRecordingInputAction(
                      actualOutputController: widget.actualOutputController,
                      action: action))
                  .toList()),
        }
      ],
    );
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
