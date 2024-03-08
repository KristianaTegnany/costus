import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({super.key, required this.text, this.hasBackground = false});

  final String text;
  final bool hasBackground;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: hasBackground
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onBackground),
      ),
    );
  }
}
