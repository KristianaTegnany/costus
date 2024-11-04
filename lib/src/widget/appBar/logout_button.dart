import 'package:costus/src/welcome/welcome_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  void logout(context) {
    final isWelcome =
        ModalRoute.of(context)?.settings.name == WelcomeView.routeName;

    FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, isWelcome ? '/' : '/login');
  }

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 500;
    return kIsWeb && !isSmall
        ? Padding(
            padding: const EdgeInsets.only(right: 40),
            child: OutlinedButton(
                onPressed: () => logout(context),
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          )
        : IconButton(
            iconSize: 25,
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          );
  }
}