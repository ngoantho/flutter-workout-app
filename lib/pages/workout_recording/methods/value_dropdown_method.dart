import 'package:flutter/material.dart';
import 'package:homework/classes/disabled_focus_node.dart';
import 'package:homework/mixins/to_dropdown.dart';
import 'package:homework/models/output.dart';

class ValueDropdownMethod extends StatefulWidget {
  final TextEditingController actualOutputController;

  const ValueDropdownMethod(this.actualOutputController, {super.key});

  @override
  State<ValueDropdownMethod> createState() => _ValueDropdownMethodState();
}

class _ValueDropdownMethodState extends State<ValueDropdownMethod>
    with DropdownMenuItemsMixin {
  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
                controller: widget.actualOutputController,
                keyboardType: TextInputType.number,
                focusNode: DisabledFocusNode(),
                decoration: InputDecoration(
                    suffixText: 'meters',
                    suffixIcon: IconButton(
                        onPressed: widget.actualOutputController.clear,
                        icon: Icon(Icons.clear))),
                validator: validateOutput)),
        SizedBox(
            width: 100,
            child: DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Add/Sub'),
                items: toDropdownMenuItemList([1, 10, 100]),
                onChanged: (value) => dropdownOnChanged(value))),
        SizedBox(
            width: 50,
            child: TextButton(
                onPressed: selectedValue != null
                    ? () => modifyActualOutput(selectedValue!)
                    : null,
                child: Icon(Icons.add))),
        SizedBox(
            width: 50,
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
  }

  void modifyActualOutput(int value) {
    Output currentOutput = widget.actualOutputController.text.toOutput();
    setState(() {
      currentOutput += value;
      widget.actualOutputController.text = currentOutput.toString();
    });
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
