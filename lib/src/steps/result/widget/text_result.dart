import 'package:flutter/material.dart';

class TextResult extends StatelessWidget {
  const TextResult({super.key, required this.label, this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return value == null
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.all(5.0),
            child: RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                  children: [
                    TextSpan(
                        text: label,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: value)
                  ]),
            ),
          );
  }
}
