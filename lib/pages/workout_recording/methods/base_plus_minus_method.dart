import 'package:flutter/material.dart';
import 'package:homework/classes/disabled_focus_node.dart';
import 'package:homework/mixins/to_dropdown.dart';
import 'package:homework/mixins/validate_output.dart';
import 'package:homework/models/output.dart';

class BasePlusMinusMethod extends StatefulWidget {
  final TextEditingController controller;

  const BasePlusMinusMethod(this.controller, {super.key});

  @override
  State<BasePlusMinusMethod> createState() => _BasePlusMinusMethodState();
}

class _BasePlusMinusMethodState extends State<BasePlusMinusMethod>
    with DropdownMenuItemsMixin, ValidateOutputMixin {
  final units = [0, 1, 5, 10, 15, 30, 45, 60];
  int? selectedBase;
  int selectedMod = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: DropdownButtonFormField(
          items: toDropdownMenuItemList(units),
          onChanged: (value) => setBaseOutput(value),
          decoration: InputDecoration(labelText: 'Base'),
        )),
        SizedBox(
          width: 50,
          child: Column(
            children: [
              IconButton.outlined(
                  onPressed: selectedBase != null
                      ? () => modifyActualOutput(selectedMod)
                      : null,
                  icon: Icon(Icons.add)),
              IconButton.outlined(
                  onPressed:
                      selectedBase != null && widget.controller.output > 0
                          ? () => modifyActualOutput(-selectedMod)
                          : null,
                  icon: Icon(Icons.remove))
            ],
          ),
        ),
        Flexible(
            child: DropdownButtonFormField(
          items: toDropdownMenuItemList(units),
          value: 0,
          onChanged: (value) => setState(
            () => selectedMod = value,
          ),
          decoration:
              InputDecoration(labelText: 'Modifier'),
        )),
        Flexible(
            child: TextFormField(
          controller: widget.controller,
          focusNode: DisabledFocusNode(),
          decoration: InputDecoration(
            labelText: 'Output',
            suffixIcon: widget.controller.hasOutput
                ? IconButton(onPressed: clearOutput, icon: Icon(Icons.clear))
                : null,
          ),
          validator: validateOutput,
        ))
      ],
    );
  }

  void setBaseOutput(int value) {
    setState(() {
      selectedBase = value;
      widget.controller.clear(); // clear first
      widget.controller.output = value;
    });
  }

  void clearOutput() {
    setBaseOutput(selectedBase!);
  }

  void modifyActualOutput(int value) {
    Output currentOutput = widget.controller.text.toOutput();
    setState(() {
      currentOutput.value += value;
      widget.controller.text = currentOutput.toString();
    });
  }
}
