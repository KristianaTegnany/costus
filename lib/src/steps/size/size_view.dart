import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:costus/src/steps/home/cubit/option_cubit.dart';
import 'package:costus/src/steps/size/cubit/size_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/size/cubit/sizes_cubit.dart';
import 'package:costus/src/widget/my_dropdown.dart';
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
          child: BlocBuilder<SizesCubit, SizesState>(builder: (context, state) {
        if (state is SizesLoaded) {
          return BlocBuilder<SizeCubit, SizeState>(
              builder: (context, sizeState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<OptionCubit, OptionState>(
                    builder: (context, optionState) {
                  return MyTitle(
                    text: (optionState as OptionChosen).chosenOption ==
                            Option.estimate
                        ? state.questionEstimate ?? ''
                        : state.question ?? '',
                    hasBackground: true,
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: MyDropDown(
                    data: state.sizes ?? [],
                    label: state.placeholder ?? '',
                    value: sizeState is SizeChosen ? sizeState.size : null,
                    onChange: (value) =>
                        context.read<SizeCubit>().onSizeChosen(value),
                  ),
                ),
                BlocBuilder<StepNavigationCubit, StepNavigationState>(
                  builder: (context, _) {
                    return RectButton(
                        text: 'Next',
                        onPress: sizeState is SizeChosen
                            ? () => context
                                .read<StepNavigationCubit>()
                                .onNextPressed()
                            : null);
                  },
                ),
              ],
            );
          });
        }
        return const SizedBox();
      })),
    );
  }
}
