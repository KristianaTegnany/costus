import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({super.key, required this.text, this.hasBackground = false});

  final String text;
  final bool hasBackground;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: hasBackground
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.primary),
    );
  }
}
