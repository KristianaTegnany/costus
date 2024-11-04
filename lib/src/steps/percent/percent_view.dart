import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/percent/cubit/percent_cubit.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/widget/my_textfield.dart';
import 'package:costus/src/widget/sample_text.dart';
import 'package:costus/src/widget/step_image.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PercentView extends StatelessWidget {
  const PercentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      StepNavigationCubit stepNavigationCubit =
          context.read<StepNavigationCubit>();
      return BlocProvider(
        create: (context) => PercentCubit(),
        child: StepLayout(
          isWebChild: kIsWeb,
          onPress: () => stepNavigationCubit.onNextPressed(),
          child: Center(child: BlocBuilder<PercentCubit, PercentState>(
            builder: (context, percentState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const StepImage('percent'),
                  MyTitle(
                    text: percentState.question ?? '',
                  ),
                  BlocBuilder<ResultCubit, ResultState>(
                    builder: (context, state) {
                      return MyTextField(
                          value: state.percent,
                          isPercent: true,
                          label: percentState.placeholder ?? '',
                          onChange: (value) {
                            context.read<ResultCubit>().onPercentChanged(value);
                          });
                    },
                  ),
                  SampleText(text: percentState.sample ?? ''),
                ],
              );
            },
          )),
        ),
      );
    });
  }
}
