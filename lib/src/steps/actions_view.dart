import 'package:costus/src/cubit/step_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionsView extends StatelessWidget {
  const ActionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return StepLayout(
      isWhite: true,
      child: Center(child: BlocBuilder<StepCubit, MyStepState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RectButton(primary: true, text: 'Print', onPress: () => {}),
              const SizedBox(
                height: 20,
              ),
              RectButton(primary: true, text: 'Email', onPress: () => {}),
              const SizedBox(
                height: 20,
              ),
              RectButton(
                  primary: true, text: 'Social Media', onPress: () => {}),
              const SizedBox(
                height: 20,
              ),
              RectButton(primary: true, text: 'Share', onPress: () => {}),
              const SizedBox(
                height: 20,
              ),
              RectButton(
                  primary: true,
                  text: 'Recalculate',
                  onPress: () => context.read<StepCubit>().onRecalculate()),
              const SizedBox(
                height: 20,
              ),
              RectButton(
                  primary: true,
                  text: 'Select New Method',
                  onPress: () => context.read<StepCubit>().onReset()),
            ],
          );
        },
      )),
    );
  }
}
