import 'package:flutter/material.dart';
import 'package:homework/widgets/recent_performance.dart';

class CommonScaffold extends StatelessWidget {
  final String title;
  final Widget content;
  final Widget? floatingActionButton;
  final Widget? appBarAction;
  final List<Widget>? bottomButtons;

  const CommonScaffold(
      {super.key,
      required this.title,
      required this.content,
      this.floatingActionButton,
      this.appBarAction,
      this.bottomButtons});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: appBarAction != null ? [appBarAction!] : null,
      ),
      body: content,
      floatingActionButton: floatingActionButton,
      persistentFooterButtons: bottomButtons,
      bottomNavigationBar: RecentPerformance(),
    );
  }
}
