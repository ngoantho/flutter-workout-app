import 'package:flutter/material.dart';
import 'package:homework/widgets/recent_performance.dart';

class CommonScaffold extends StatelessWidget {
  final String title;
  final Widget content;
  final Widget? floatingActionButton;
  final List<Widget> appBarActions;
  final Widget? appBarAction;

  const CommonScaffold(
      {super.key,
      required this.title,
      required this.content,
      this.floatingActionButton,
      this.appBarActions = const [],
      this.appBarAction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: appBarAction != null ? [appBarAction!] : appBarActions,
      ),
      body: content,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: RecentPerformance(),
    );
  }
}
