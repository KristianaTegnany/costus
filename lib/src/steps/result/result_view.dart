import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/home/cubit/option_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/steps/result/widget/text_result.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return StepLayout(
      isWhite: true,
      child: Center(
          child: BlocBuilder<ResultCubit, ResultState>(
        buildWhen: (previous, current) =>
            previous.formatedResult != current.formatedResult,
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MyTitle(
                text: "Result",
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Icon(
                  Icons.star,
                  size: 100,
                ),
              ),
              BlocBuilder<OptionCubit, OptionState>(builder: (_, optionState) {
                if (optionState is OptionChosen) {
                  context
                      .read<ResultCubit>()
                      .setFormatedResult(optionState.chosenOption);
                  final result = state.formatedResult ?? '';
                  if (result.isEmpty) {
                    return const SizedBox();
                  }

                  switch (optionState.chosenOption) {
                    case Option.difference:
                    case Option.m2:
                    case Option.estimate:
                      return Text(
                        '£$result',
                        style: const TextStyle(fontSize: 18),
                      );
                    case Option.average:
                      return Column(
                        children: [
                          TextResult(
                            label: 'Labour Rate: ',
                            value: '${result.split('/')[0]} per man hour',
                          ),
                          TextResult(
                              label: 'Material profit: ',
                              value: result.split('/')[1])
                        ],
                      );
                    default:
                      return const SizedBox();
                  }
                }
                return CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.background,
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
              })
            ],
          );
        },
      )),
    );
  }
}
