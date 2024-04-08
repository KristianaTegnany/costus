import 'package:costus/src/steps/home/cubit/option_cubit.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/size/cubit/sizes_cubit.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:costus/src/widget/my_textfield.dart';
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
          return BlocBuilder<ResultCubit, ResultState>(
              builder: (context, resultState) {
            return BlocBuilder<OptionCubit, OptionState>(
                builder: (_, optionState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTitle(
                    text: (optionState as OptionChosen).chosenOption ==
                            Option.estimate
                        ? state.questionEstimate ?? ''
                        : state.question ?? '',
                    hasBackground: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: optionState.chosenOption == Option.average
                        ? MyDropDown(
                            data: state.sizes ?? [],
                            label: state.placeholder ?? '',
                            value: resultState.size,
                            onChange: (value) => context
                                .read<ResultCubit>()
                                .onSizeChanged(value),
                          )
                        : MyTextField(
                            value: resultState.size,
                            label: state.placeholder ?? '',
                            onChange: (value) => context
                                .read<ResultCubit>()
                                .onSizeChanged(value)),
                  ),
                  BlocBuilder<StepNavigationCubit, StepNavigationState>(
                    builder: (context, _) {
                      return RectButton(
                          text: 'Next',
                          onPress: resultState.size != null
                              ? () => context
                                  .read<StepNavigationCubit>()
                                  .onNextPressed()
                              : null);
                    },
                  ),
                ],
              );
            });
          });
        }
        return CircularProgressIndicator(
          color: Theme.of(context).colorScheme.background,
        );
      })),
    );
  }
}
