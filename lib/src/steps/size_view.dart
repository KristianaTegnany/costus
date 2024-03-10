import 'package:costus/src/cubit/option_cubit.dart';
import 'package:costus/src/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SizeView extends StatelessWidget {
  const SizeView({super.key});

  @override
  Widget build(BuildContext context) {
    return StepLayout(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<OptionCubit, OptionState>(builder: (context, state) {
            return MyTitle(
              text: (state as OptionChoosen).choosenOption == Option.estimate
                  ? "Size of project m2?"
                  : "Size of the project?",
              hasBackground: true,
            );
          }),
          const SizedBox(
            height: 40,
          ),
          BlocBuilder<StepNavigationCubit, StepNavigationState>(
            builder: (context, state) {
              return RectButton(
                  text: 'Next',
                  onPress: () =>
                      context.read<StepNavigationCubit>().onNextPressed());
            },
          ),
        ],
      )),
    );
  }
}
