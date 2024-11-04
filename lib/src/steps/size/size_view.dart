import 'package:costus/src/steps/home/cubit/option_cubit.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/size/cubit/sizes_cubit.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:costus/src/widget/my_textfield.dart';
import 'package:costus/src/widget/sample_text.dart';
import 'package:costus/src/widget/step_image.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SizeView extends StatelessWidget {
  const SizeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ResultCubit resultCubit = context.read<ResultCubit>();
      ResultState resultState = context.watch<ResultCubit>().state;
      StepNavigationCubit stepNavigationCubit =
          context.read<StepNavigationCubit>();

      return BlocProvider(
        create: (context) => SizesCubit(),
        child: StepLayout(
          isWebChild: kIsWeb,
          onPress: () => stepNavigationCubit.onNextPressed(),
          buttonDisabled: resultState.size == null,
          child: Center(child:
              BlocBuilder<SizesCubit, SizesState>(builder: (context, state) {
            if (state is SizesLoaded) {
              return BlocBuilder<OptionCubit, OptionState>(
                  builder: (_, optionState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const StepImage('size'),
                    MyTitle(
                      text: (optionState as OptionChosen).chosenOption ==
                              Option.estimate
                          ? state.questionEstimate ?? ''
                          : state.question ?? '',
                    ),
                    optionState.chosenOption == Option.estimate
                        ? MyTextField(
                            value: resultState.size,
                            label: state.placeholder ?? '',
                            onChange: (value) =>
                                resultCubit.onSizeChanged(value))
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: MyDropDown(
                              data: state.sizes ?? [],
                              label: state.placeholder ?? '',
                              value: resultState.size,
                              onChange: (value) =>
                                  resultCubit.onSizeChanged(value),
                            ),
                          ),
                    SampleText(
                        text: (optionState.chosenOption == Option.estimate
                                ? state.sampleEstimate
                                : state.sample) ??
                            ''),
                  ],
                );
              });
            }
            return const CircularProgressIndicator(
              color: background,
            );
          })),
        ),
      );
    });
  }
}
