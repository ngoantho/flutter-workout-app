import 'package:flutter/material.dart';
import 'package:homework/widgets/common_scaffold.dart';

class DownloadPlanPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  DownloadPlanPage({super.key});

  void download() {}

  Widget get formContent => TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: "URL",
            suffixIcon:
                IconButton(onPressed: download, icon: Icon(Icons.send))),
      );

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        title: 'Download Workout Plan',
        content: Form(
          key: _formKey,
          child: formContent,
        ));
  }
}
