import 'package:costus/src/steps/competition/cubit/competitions_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompetitionView extends StatelessWidget {
  const CompetitionView({super.key});

  @override
  Widget build(BuildContext context) {
    return StepLayout(
      child: Center(child: Builder(
        builder: (context) {
          final state = context.watch<CompetitionsCubit>().state;
          final competition = context.watch<ResultCubit>().state.competition;

          if (state is CompetitionsLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTitle(
                  text: state.question ?? '',
                  hasBackground: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: MyDropDown(
                    data: state.competitions ?? [],
                    label: state.placeholder ?? '',
                    value: competition,
                    onChange: (value) =>
                        context.read<ResultCubit>().onCompetitionChanged(value),
                  ),
                ),
                BlocBuilder<StepNavigationCubit, StepNavigationState>(
                    builder: (context, _) {
                  return RectButton(
                      text: 'Next',
                      onPress: competition != null
                          ? () => context
                              .read<StepNavigationCubit>()
                              .onNextPressed()
                          : null);
                }),
              ],
            );
          }
          return CircularProgressIndicator(
            color: Theme.of(context).colorScheme.background,
          );
        },
      )),
    );
  }
}
