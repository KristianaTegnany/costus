import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key, required this.text, required this.onPress});

  final String text;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: const ButtonStyle(
          padding:
              MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20))),
      onPressed: onPress,
      child: Text(text),
    );
  }
}
