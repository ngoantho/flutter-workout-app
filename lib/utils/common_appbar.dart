import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CommonAppBar(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      // centerTitle: true,
      actions: [profileAction],
    );
  }

  Widget get profileAction => StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final user = snapshot.data!;

        viewUID() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              user.uid,
              textAlign: TextAlign.center,
            ),
            duration: Duration(seconds: 1),
          ));
        }

        return OutlinedButton(onPressed: viewUID, child: Text('View UID'));
      });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
