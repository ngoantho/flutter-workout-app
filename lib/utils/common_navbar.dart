import 'package:flutter/material.dart';
import 'package:homework/utils/recent_perf.dart';

class CommonNavbar extends StatelessWidget {
  final Widget? top;

  const CommonNavbar({super.key, this.top});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: RecentPerformance(top: top),
        subtitle: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.person),
              text: 'Solo',
            ),
            Tab(
              icon: Icon(Icons.handshake),
              text: 'Collaborative',
            ),
            Tab(
              icon: Icon(Icons.numbers),
              text: 'Competitive',
            )
          ],
        ));
  }
}
