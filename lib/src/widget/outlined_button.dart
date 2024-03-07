import 'package:flutter/material.dart';

class MyOutlinedButton extends StatelessWidget {
  const MyOutlinedButton(
      {super.key, required this.text, required this.onPress});

  final String text;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: const ButtonStyle(
          side: MaterialStatePropertyAll(BorderSide.none),
          padding:
              MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20))),
      onPressed: onPress,
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
