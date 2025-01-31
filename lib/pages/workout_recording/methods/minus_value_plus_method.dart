import 'package:flutter/material.dart';
import 'package:homework/classes/disabled_focus_node.dart';
import 'package:homework/mixins/validate_output.dart';
import 'package:homework/models/output.dart';

class MinusValuePlusMethod extends StatefulWidget {
  final TextEditingController controller;

  const MinusValuePlusMethod(this.controller, {super.key});

  @override
  State<MinusValuePlusMethod> createState() => _MinusValuePlusMethodState();
}

class _MinusValuePlusMethodState extends State<MinusValuePlusMethod> with ValidateOutputMixin {
  @override
  void initState() {
    super.initState();
    setState(() {
      widget.controller.output = 0;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Wrap(
          children: [1, 10]
              .map((val) => TextButton(
                  onPressed: widget.controller.output > 0
                      ? () => modifyActualOutput(-val)
                      : null,
                  child: Text('-$val')))
              .toList(),
        ),
        Expanded(
            child: TextFormField(
          controller: widget.controller,
          focusNode: DisabledFocusNode(),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              suffixText: 'reps',
              suffixIcon: widget.controller.hasOutput ? IconButton(
                  onPressed: clearOutput,
                  icon: Icon(Icons.clear)) : null),
          validator: validateOutput,
        )),
        Wrap(
          children: [1, 10]
              .map((val) => TextButton(
                  onPressed: () => modifyActualOutput(val),
                  child: Text('+$val')))
              .toList(),
        ),
      ],
    );
  }

  void clearOutput() {
    setState(() => widget.controller.clear());
  }

  void modifyActualOutput(int value) {
    Output currentOutput = widget.controller.text.toOutput();
    setState(() {
      currentOutput += value;
      widget.controller.text = currentOutput.toString();
    });
  }
}
