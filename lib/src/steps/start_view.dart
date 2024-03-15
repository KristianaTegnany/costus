import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/material.dart';

const Map<Option, String> titles = {
  Option.average: "Average Rate Calculation",
  Option.difference: "Difference Rate Sample",
  Option.m2: "m2 rate",
  Option.estimate: "estimate on m2"
};

class StartView extends StatelessWidget {
  const StartView(
      {super.key, required this.chosenOption, required this.onPress});

  final Option? chosenOption;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTitle(
          text: titles[chosenOption]!,
          hasBackground: true,
        ),
        const SizedBox(
          height: 40,
        ),
        RectButton(text: 'Start', onPress: onPress),
      ],
    );
  }
}
