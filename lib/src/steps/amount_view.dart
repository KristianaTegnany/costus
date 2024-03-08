import 'package:costus/src/cubit/step_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmountView extends StatelessWidget {
  const AmountView({super.key});

  @override
  Widget build(BuildContext context) {
    return StepLayout(
      child: Center(child: BlocBuilder<StepCubit, MyStepState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MyTitle(
                text: "What amount?",
                hasBackground: true,
              ),
              const SizedBox(
                height: 40,
              ),
              RectButton(
                  text: 'Next',
                  onPress: () => context.read<StepCubit>().onNextPressed()),
            ],
          );
        },
      )),
    );
  }
}
