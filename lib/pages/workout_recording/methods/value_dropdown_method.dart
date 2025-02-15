import 'package:flutter/material.dart';
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
    with DropdownMenuItemsMixin<int>, ValidateOutputMixin {
  final units = [for (var i = 1; i <= 60; i++) i];

  void onChanged(int value) {
    setState(() {
      widget.controller.output = value;
    });
  }

  void clearOutput() {
    setState(() {
      widget.controller.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final dropdown = DropdownButtonFormField(
      items: toDropdownMenuItemList(units),
      value: switch (widget.controller.hasOutput) {
        true => widget.controller.output,
        false => null
      },
      onChanged: (unit) => onChanged(unit!),
      decoration: InputDecoration(
        labelText: "Output",
        suffixIcon: switch (widget.controller.hasOutput) {
          true => IconButton(
              onPressed: clearOutput,
              icon: Icon(Icons.settings_backup_restore)),
          false => null
        },
      ),
    );
    return Stack(
      children: [
        TextFormField(
          controller: widget.controller,
          validator: validateOutput,
          style: TextStyle(color: Colors.transparent)
        ),
        dropdown,
      ],
    );
  }
}
