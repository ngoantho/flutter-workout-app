import 'package:flutter/material.dart';
import 'package:homework/mixins/to_dropdown.dart';
import 'package:homework/mixins/validate_output.dart';
import 'package:homework/models/output.dart';
import 'package:homework/widgets/sized_box/sized_box_with_width.dart';

class ValueDropdownMethod extends StatefulWidget {
  final TextEditingController controller;

  const ValueDropdownMethod(this.controller, {super.key});

  @override
  State<ValueDropdownMethod> createState() => _ValueDropdownMethodState();
}

class _ValueDropdownMethodState extends State<ValueDropdownMethod>
    with DropdownMenuItemsMixin, ValidateOutputMixin {
  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              suffixText: 'meters',
              suffixIcon: widget.controller.hasOutput
                  ? IconButton(onPressed: clearOutput, icon: Icon(Icons.clear))
                  : null),
          validator: validateOutput,
          onChanged: (_) => setState(() {}), // show clear button
        )),
        SizedBoxWithWidth(10),
        SizedBox(
            width: 100,
            child: DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Add/Sub'),
                items: toDropdownMenuItemList([1, 10, 100]),
                onChanged: (value) => dropdownOnChanged(value))),
        SizedBox(
            child: IconButton.filledTonal(
                onPressed: selectedValue != null
                    ? () => modifyActualOutput(selectedValue!)
                    : null,
                icon: Icon(Icons.add))),
        SizedBox(
            child: IconButton.filledTonal(
                onPressed: selectedValue != null && widget.controller.output > 0
                    ? () => modifyActualOutput(-selectedValue!)
                    : null,
                icon: Icon(Icons.remove)))
      ],
    );
  }

  void dropdownOnChanged(int value) {
    setState(() => selectedValue = value);
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
