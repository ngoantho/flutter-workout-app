import 'package:flutter/material.dart';
import 'package:homework/mixins/to_dropdown.dart';
import 'package:homework/models/output.dart';

class WorkoutRecordingInputAction extends StatefulWidget {
  final TextEditingController actualOutputController;
  final List<int> values;
  final FocusNode focusNode;

  const WorkoutRecordingInputAction(
      {required this.actualOutputController, required this.values, required this.focusNode, super.key});

  @override
  State<WorkoutRecordingInputAction> createState() =>
      _WorkoutRecordingInputActionState();
}

class _WorkoutRecordingInputActionState
    extends State<WorkoutRecordingInputAction> with DropdownMenuItemsMixin {
  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SizedBox(
            width: 75,
            child: DropdownButtonFormField(
                items: toDropdownMenuItemList(widget.values),
                onChanged: (value) => dropdownOnChanged(value))),
        SizedBox(
            width: (1 / 3) * 100,
            child: TextButton(
                onPressed: selectedValue != null
                    ? () => modifyActualOutput(selectedValue!)
                    : null,
                child: Icon(Icons.add))),
        SizedBox(
            width: (1 / 3) * 100,
            child: TextButton(
                onPressed: selectedValue != null
                    ? () => modifyActualOutput(-selectedValue!)
                    : null,
                child: Icon(Icons.remove)))
      ],
    );
  }

  void dropdownOnChanged(int value) {
    setState(() => selectedValue = value);
    widget.focusNode.requestFocus();
  }

  void modifyActualOutput(int value) {
    Output currentOutput = widget.actualOutputController.text.toOutput();
    setState(() {
      currentOutput += value;
      widget.actualOutputController.text = currentOutput.toString();
    });
  }
}
