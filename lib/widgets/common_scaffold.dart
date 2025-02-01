import 'package:flutter/material.dart';
import 'package:homework/widgets/recent_performance.dart';

class CommonScaffold extends StatelessWidget {
  final String title;
  final Widget content;

  const CommonScaffold({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: content,
      bottomNavigationBar: RecentPerformance(),
    );
  }
}
