import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MyOutlinedButton extends StatelessWidget {
  const MyOutlinedButton(
      {super.key,
      this.disabled = false,
      required this.text,
      required this.onPress});

  final String text;
  final void Function() onPress;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kIsWeb ? 10 : 0),
      child: OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.primary.withOpacity(0.1)),
            side: const MaterialStatePropertyAll(BorderSide.none),
            padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(
                vertical: kIsWeb ? 20 : 0, horizontal: kIsWeb ? 40 : 20))),
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(disabled ? 0.5 : 1),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
