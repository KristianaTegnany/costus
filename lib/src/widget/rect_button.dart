import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class RectButton extends StatelessWidget {
  const RectButton(
      {super.key, this.primary = false, required this.text, this.onPress});

  final String text;
  final bool primary;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    final double opacity = onPress != null ? 1 : 0.7;

    return FilledButton(
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(primary
              ? Theme.of(context).colorScheme.primary.withOpacity(opacity)
              : Theme.of(context).colorScheme.onPrimary.withOpacity(opacity)),
          elevation: const MaterialStatePropertyAll(5),
          foregroundColor:
              MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
          shape: const MaterialStatePropertyAll(BeveledRectangleBorder()),
          padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(
              horizontal: 40, vertical: kIsWeb ? 20 : 10))),
      onPressed: onPress,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primary
                ? Theme.of(context).colorScheme.onPrimary.withOpacity(opacity)
                : Theme.of(context).colorScheme.primary.withOpacity(opacity)),
      ),
    );
  }
}
