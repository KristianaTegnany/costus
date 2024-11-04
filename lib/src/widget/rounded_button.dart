import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      required this.text,
      required this.onPress,
      this.animate = false});

  final String text;
  final void Function() onPress;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: const ButtonStyle(
          padding:
              WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20))),
      onPressed: onPress,
      child: Text(text).animate(
          onPlay: (controller) => controller.repeat(),
          effects: animate
              ? [const ShakeEffect(delay: Durations.extralong4)]
              : EffectList()),
    );
  }
}
