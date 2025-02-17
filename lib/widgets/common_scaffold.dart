import 'package:flutter/material.dart';
import 'package:homework/widgets/min_height_column.dart';
import 'package:homework/widgets/recent_performance.dart';

class CommonScaffold extends StatelessWidget {
  final String title;
  final Widget? content;
  final Widget? floatingActionButton;
  final List<Widget> appBarActions;
  final Widget? bottomWidget;

  const CommonScaffold({
    super.key,
    required this.title,
    this.content,
    this.floatingActionButton,
    this.appBarActions = const [],
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar:
          AppBar(title: Text(title), centerTitle: true, actions: appBarActions),
      body: content,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: MinHeightColumn(
        [if (bottomWidget != null) bottomWidget!, RecentPerformance()],
      ),
    ));
  }
}
