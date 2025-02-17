import 'package:flutter/material.dart';
import 'package:homework/mixins/validate_output.dart';
import 'package:homework/typedefs/output.dart';

class ValueInputMethod extends StatefulWidget {
  final TextEditingController controller;

  const ValueInputMethod(this.controller, {super.key});

  @override
  State<ValueInputMethod> createState() => _ValueInputMethodState();
}

class _ValueInputMethodState extends State<ValueInputMethod>
    with ValidateOutputMixin {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      // textAlign: TextAlign.center,
      decoration: InputDecoration(
          labelText: 'Output',
          suffixIcon: widget.controller.hasOutput
              ? IconButton(onPressed: clearOutput, icon: Icon(Icons.backspace))
              : null),
      validator: validateOutput,
    );
  }

  void clearOutput() {
    setState(() {
      widget.controller.clear();
    });
  }
}
