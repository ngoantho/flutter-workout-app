import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homework/pages/workout_history/workout_history_page.dart';

class StartSignIn extends StatelessWidget {
  const StartSignIn({super.key});

  Scaffold get loading {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text('Signing In...')
          ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: FirebaseAuth.instance.signInAnonymously(), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return loading;
      }

      return WorkoutHistoryPage();
    });
  }
}