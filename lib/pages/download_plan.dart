import 'package:flutter/material.dart';
import 'package:homework/widgets/common_scaffold.dart';
import 'package:validators/validators.dart';

class DownloadPlanPage extends StatefulWidget {
  const DownloadPlanPage({super.key});

  @override
  State<DownloadPlanPage> createState() => _DownloadPlanPageState();
}

class _DownloadPlanPageState extends State<DownloadPlanPage> {
  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  Widget icon = Icon(Icons.send);

  void download() async {
    setState(() {
      icon = CircularProgressIndicator();
    });
    if (_formKey.currentState!.validate()) {
      // make request
    }
  }

  void resetIcon() {
    setState(() {
      icon = Icon(Icons.send);
    });
  }

  String? validate(String? url) {
    if (url == null || url.isEmpty) {
      resetIcon();
      return "Enter a URL";
    }
    if (!isURL(url)) {
      resetIcon();
      return "Invalid URL";
    }
    return null;
  }

  Widget get formContent => TextFormField(
        controller: controller,
        validator: validate,
        keyboardType: TextInputType.url,
        decoration: InputDecoration(
            labelText: "URL",
            suffixIcon: IconButton(onPressed: download, icon: icon)),
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
