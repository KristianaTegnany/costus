import 'package:costus/src/steps/home/cubit/option_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/widget/outlined_button.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return StepLayout(
      isWhite: true,
      child: BlocBuilder<OptionCubit, OptionState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MyTitle(text: 'Which rate shall I use?'),
              const SizedBox(
                height: 40,
              ),
              MyOutlinedButton(
                  text: 'Average Rate',
                  onPress: () => context
                      .read<OptionCubit>()
                      .onOptionChosen(Option.average)),
              MyOutlinedButton(
                  text: 'Difference Rate',
                  onPress: () => context
                      .read<OptionCubit>()
                      .onOptionChosen(Option.difference)),
              MyOutlinedButton(
                  text: 'm2 Rate',
                  onPress: () =>
                      context.read<OptionCubit>().onOptionChosen(Option.m2)),
              MyOutlinedButton(
                  text: 'Estimate on m2 Rate',
                  onPress: () => context
                      .read<OptionCubit>()
                      .onOptionChosen(Option.estimate)),
            ],
          );
        },
      ),
    );
  }
}
