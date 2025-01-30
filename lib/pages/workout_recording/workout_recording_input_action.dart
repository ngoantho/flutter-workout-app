import 'package:flutter/material.dart';
import 'package:homework/models/output.dart';

class WorkoutRecordingInputAction extends StatefulWidget {
  final TextEditingController actualOutputController;
  final String action;

  const WorkoutRecordingInputAction(
      {required this.actualOutputController, required this.action, super.key});

  @override
  State<WorkoutRecordingInputAction> createState() => _WorkoutRecordingInputActionState();
}

class _WorkoutRecordingInputActionState extends State<WorkoutRecordingInputAction> {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {
      int value = int.parse(widget.action);
      Output currentOutput = widget.actualOutputController.text.toOutput();
      setState(() {
        currentOutput += value;
        widget.actualOutputController.text = currentOutput.toString();
      });
    }, child: Text(widget.action));
  }
}
