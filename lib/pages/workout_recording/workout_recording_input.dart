import 'package:flutter/material.dart';
import 'package:homework/models/measurement_unit.dart';

class WorkoutRecordingInput extends StatefulWidget {
  final TextEditingController actualOutputController;
  final MeasurementUnit unit;

  const WorkoutRecordingInput(this.actualOutputController, this.unit,
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
                decoration: InputDecoration(labelText: 'Actual Output'),
                validator: validateOutput)),
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
