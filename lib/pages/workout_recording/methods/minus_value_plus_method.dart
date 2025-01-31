import 'package:flutter/material.dart';
import 'package:homework/classes/disabled_focus_node.dart';
import 'package:homework/models/output.dart';

class MinusValuePlusMethod extends StatefulWidget {
  final TextEditingController controller;

  const MinusValuePlusMethod(this.controller, {super.key});

  @override
  State<MinusValuePlusMethod> createState() => _MinusValuePlusMethodState();
}

class _MinusValuePlusMethodState extends State<MinusValuePlusMethod> {
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
              suffixIcon: widget.controller.output != 0
                  ? IconButton(onPressed: clearOutput, icon: Icon(Icons.clear))
                  : null),
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
    setState(() => widget.controller.output = 0);
  }

  void modifyActualOutput(int value) {
    setState(() => widget.controller.output += value);
  }
}
