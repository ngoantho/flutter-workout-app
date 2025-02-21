import 'package:flutter/material.dart';
import 'package:homework/mixins/to_dropdown.dart';
import 'package:homework/mixins/validate_output.dart';
import 'package:homework/typedefs/output.dart';

class ValueDropdownMethod extends StatefulWidget {
  final TextEditingController controller;

  const ValueDropdownMethod(this.controller, {super.key});

  @override
  State<ValueDropdownMethod> createState() => _ValueDropdownMethodState();
}

class _ValueDropdownMethodState extends State<ValueDropdownMethod>
    with DropdownMenuMixin<int>, ValidateOutputMixin {
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
    final icon = IconButton(
        onPressed: clearOutput, icon: Icon(Icons.settings_backup_restore));
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
          true => icon,
          false => null
        },
      ),
    );
    final textField = TextFormField(
      controller: widget.controller,
      validator: validateOutput,
      decoration: InputDecoration(labelText: "Output", suffixIcon: icon),
    );
    return DefaultTabController(
        length: 2,
        child: Column(children: [
          TabBar(tabs: [
            Tab(
              text: 'Dropdown',
            ),
            Tab(
              text: 'Manual',
            )
          ]),
          SizedBox(
            height: 50,
            child: TabBarView(children: [dropdown, textField]),
          )
        ]));
  }
}
