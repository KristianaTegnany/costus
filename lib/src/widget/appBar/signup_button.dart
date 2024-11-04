import 'package:costus/src/widget/rounded_button.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  void goToSignup(context) {
    Navigator.pushNamed(context, '/signup');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: RoundedButton(onPress: () => goToSignup(context), text: 'Sign Up'),
    );
  }
}