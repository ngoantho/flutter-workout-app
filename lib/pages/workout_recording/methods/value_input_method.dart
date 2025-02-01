import 'package:flutter/material.dart';
import 'package:homework/mixins/to_dropdown.dart';
import 'package:homework/mixins/validate_output.dart';
import 'package:homework/models/output.dart';

class ValueInputMethod extends StatefulWidget {
  final TextEditingController controller;

  const ValueInputMethod(this.controller, {super.key});

  @override
  State<ValueInputMethod> createState() => _ValueInputMethodState();
}

class _ValueInputMethodState extends State<ValueInputMethod>
    with DropdownMenuItemsMixin, ValidateOutputMixin {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          prefixText: 'Output: ',
          suffixIcon: widget.controller.hasOutput
              ? IconButton(onPressed: clearOutput, icon: Icon(Icons.backspace))
              : null),
      validator: validateOutput,
      onChanged: (_) => setState(() {}), // show clear button
    );
  }

  void clearOutput() {
    setState(() {
      widget.controller.clear();
    });
  }
}
