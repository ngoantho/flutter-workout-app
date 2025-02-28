import 'package:flutter/material.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/recent_perf.dart';

class CommonScaffold extends StatelessWidget with NavigateMixin {
  final String title;
  final Widget? content;
  final Widget? floatingActionButton;
  final Widget? bottomWidget;
  final String? subtitle;

  const CommonScaffold(
      {super.key,
      required this.title,
      this.content,
      this.floatingActionButton,
      this.bottomWidget,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(title),
              flexibleSpace: RecentPerformance(),
            ),
            body: content,
            floatingActionButton: floatingActionButton,
            bottomNavigationBar: bottomWidget));
  }
}
