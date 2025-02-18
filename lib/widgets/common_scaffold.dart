import 'package:flutter/material.dart';
import 'package:homework/widgets/min_height_column.dart';
import 'package:homework/widgets/recent_performance.dart';

class CommonScaffold extends StatelessWidget {
  final String title;
  final Widget? content;
  final Widget? floatingActionButton;
  final Widget? bottomWidget;
  final PreferredSizeWidget? topWidget;

  const CommonScaffold(
      {super.key,
      required this.title,
      this.content,
      this.floatingActionButton,
      this.bottomWidget,
      this.topWidget});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [backHome(context)],
        bottom: topWidget,
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
        onPressed: () {
          Navigator.of(context).popUntil(
            (route) {
              return route.isFirst;
            },
          );
        },
        icon: Icon(Icons.home));
  }
}
