import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homework/enums/workout_type.dart';
import 'package:homework/pages/workout_history/workout_history_page.dart';

class StartSignIn extends StatelessWidget {
  const StartSignIn({super.key});

  Scaffold get loading {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator(), Text('Signing In...')],
      ),
    ));
  }

  List<Widget> get tabs {
    return [
      Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (_) => WorkoutHistoryPage(WorkoutType.solo),
            settings: RouteSettings(name: '/solo')),
      ),
      Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (_) => WorkoutHistoryPage(WorkoutType.collaborative),
            settings: RouteSettings(name: '/collaborative')),
      ),
      Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (_) => WorkoutHistoryPage(WorkoutType.competitive),
            settings: RouteSettings(name: '/competitive')),
      ),
    ];
  }

  DefaultTabController get tabController {
    return DefaultTabController(length: 3, child: TabBarView(children: tabs));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.signInAnonymously(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loading;
          }

          return tabController;
        });
  }
}
