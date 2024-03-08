import 'package:flutter/material.dart';

class RectButton extends StatelessWidget {
  const RectButton(
      {super.key,
      this.primary = false,
      required this.text,
      required this.onPress});

  final String text;
  final bool primary;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(primary
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimary),
          elevation: const MaterialStatePropertyAll(5),
          foregroundColor:
              MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
          shape: const MaterialStatePropertyAll(BeveledRectangleBorder()),
          padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 40, vertical: 10))),
      onPressed: onPress,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primary
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
