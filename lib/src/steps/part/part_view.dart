import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/part/cubit/part_cubit.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartView extends StatelessWidget {
  const PartView({super.key});

  @override
  Widget build(BuildContext context) {
    return StepLayout(child: Center(
      child: BlocBuilder<PartsCubit, PartsState>(
        builder: (context, state) {
          if (state is PartsLoaded) {
            return BlocBuilder<ResultCubit, ResultState>(
                builder: (context, resultState) {
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
                          data: state.parts ?? [],
                          label: state.placeholder ?? '',
                          value: resultState.part,
                          onChange: (value) =>
                              context.read<ResultCubit>().onPartChanged(value),
                        )),
                    BlocBuilder<StepNavigationCubit, StepNavigationState>(
                        builder: (context, _) {
                      return RectButton(
                          text: 'Next',
                          onPress: resultState.part != null
                              ? () => context
                                  .read<StepNavigationCubit>()
                                  .onNextPressed()
                              : null);
                    })
                  ]);
            });
          }
          return CircularProgressIndicator(
            color: Theme.of(context).colorScheme.background,
          );
        },
      ),
    ));
  }
}
