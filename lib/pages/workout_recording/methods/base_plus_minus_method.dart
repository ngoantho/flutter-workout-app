import 'package:flutter/material.dart';
import 'package:homework/classes/disabled_focus_node.dart';
import 'package:homework/mixins/to_dropdown.dart';
import 'package:homework/mixins/validate_output.dart';
import 'package:homework/models/output.dart';
import 'package:homework/widgets/sized_box/sized_box_with_width.dart';

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
          decoration: InputDecoration(labelText: 'Output'),
        )),
        SizedBox(
          width: 50,
          child: Column(
            children: [
              IconButton.filledTonal(
                  onPressed: selectedBase != null
                      ? () => modifyActualOutput(selectedMod)
                      : null,
                  icon: Icon(Icons.add)),
              IconButton.filledTonal(
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
          decoration: InputDecoration(labelText: 'Add/Sub'),
        )),
        SizedBoxWithWidth(10),
        Flexible(
            child: TextFormField(
          controller: widget.controller,
          focusNode: DisabledFocusNode(),
          decoration: InputDecoration(
            labelText: 'Final',
            border: InputBorder.none,
            suffixIcon: widget.controller.hasOutput && widget.controller.output != selectedBase
                ? IconButton(onPressed: clearOutput, icon: Icon(Icons.settings_backup_restore))
                : null,
          ),
          validator: (output) =>
              validateOutput(output, incomplete: 'Select base unit'),
        ))
      ],
    );
  }

  void setBaseOutput(int value) {
    setState(() {
      selectedBase = value;
      widget.controller.output = value;
    });
  }

  void clearOutput() {
    setBaseOutput(selectedBase!);
  }

  void modifyActualOutput(int value) {
    setState(() {
      widget.controller.output += value;
    });
  }
}
