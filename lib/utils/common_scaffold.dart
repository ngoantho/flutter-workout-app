import 'package:flutter/material.dart';
import 'package:homework/mixins/navigate_to.dart';
import 'package:homework/utils/min_height_column.dart';
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

  PreferredSize? get subtitleWidget {
    return switch (subtitle != null) {
      true => PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight / 2),
          child: Transform.translate(
            offset: Offset(0, -(kToolbarHeight / 4)),
            child: Text(
              subtitle!,
              textAlign: TextAlign.center,
            ),
          )),
      false => null
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [backHome(context)],
        bottom: subtitleWidget,
      ),
      body: content,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: MinHeightColumn(
        [if (bottomWidget != null) bottomWidget!, RecentPerformance()],
      ),
    ));
  }

  IconButton backHome(BuildContext context) {
    return IconButton(
        onPressed: navigate(context).home, icon: Icon(Icons.home));
  }
}
