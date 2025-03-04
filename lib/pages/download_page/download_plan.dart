import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/models/exercise.dart';
import 'package:homework/models/workout_plan.dart';
import 'package:homework/pages/download_page/display_plan.dart';
import 'package:homework/utils/common_scaffold.dart';
import 'package:homework/utils/min_height_column.dart';
import 'package:homework/utils/sized_box/sized_box_with_height.dart';
import 'package:http/http.dart' as http;
import 'package:validators/validators.dart';

class DownloadPlanPage extends StatefulWidget {
  const DownloadPlanPage({super.key});

  @override
  State<DownloadPlanPage> createState() => _DownloadPlanPageState();
}

class _DownloadPlanPageState extends State<DownloadPlanPage>
    with NavigateMixin {
  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  Widget? _icon;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    icon = null;
  }

  Future<(String?, String?)> makeRequest() async {
    var client = http.Client();
    try {
      final url = Uri.parse(controller.text);
      final response = await client.get(url);
      return switch (response.statusCode) {
        200 => (response.body, null),
        404 => (null, "workout plan not found"),
        int() => (null, "unknown response code"),
      };
    } catch (e) {
      return (null, e.toString());
    } finally {
      client.close();
      icon = null;
    }
  }

  void download() async {
    icon = CircularProgressIndicator();
    if (_formKey.currentState!.validate()) {
      final (String? response, String? error) = await makeRequest();
      if (error != null) {
        errorText = error;
      } else {
        errorText = null;
        if (isJSON(response)) {
          Map<String, dynamic> json = jsonDecode(response!);
          final workoutPlan = WorkoutPlan.fromJson(json, controller.text);
          final exercises = List.from(json['exercises'])
              .map((e) => Exercise.fromJson(e))
              .toList();
          navigate(context).to(DisplayPlanPage(workoutPlan, exercises));
        } else {
          errorText = "response is not JSON";
        }
      }
    }
  }

  set icon(Widget? newIcon) {
    setState(() {
      _icon = switch (newIcon != null) {
        true => newIcon!,
        false => Icon(Icons.download)
      };
    });
  }

  Widget get icon => _icon!;

  set errorText(String? newErrorText) {
    setState(() {
      _errorText =
          switch (newErrorText != null) { true => newErrorText, false => null };
    });
  }

  String? get errorText => _errorText;

  String? validateURL(String? url) {
    if (url == null || url.isEmpty) {
      icon = null;
      return "Enter a URL";
    }
    if (!isURL(url)) {
      icon = null;
      return "Invalid URL";
    }
    return null;
  }

  Widget get formContent {
    return MinHeightColumn(
      [
        TextFormField(
          controller: controller,
          validator: validateURL,
          keyboardType: TextInputType.url,
          decoration: InputDecoration(labelText: "URL", errorText: errorText),
        ),
        SizedBoxWithHeight(16),
        Transform.scale(
            scale: 1.5,
            child: TextButton.icon(
              onPressed: download,
              label: Text("Download"),
              icon: icon,
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        title: 'Download Plan',
        content: Form(
          key: _formKey,
          child: formContent,
        ));
  }
}
