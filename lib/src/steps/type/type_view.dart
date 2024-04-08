import 'package:costus/src/steps/home/cubit/option_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/steps/type/cubit/types_cubit.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TypeView extends StatelessWidget {
  const TypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return StepLayout(
      child: Center(child: Builder(builder: (context) {
        final state = context.watch<TypesCubit>().state;
        final type = context.watch<ResultCubit>().state.type;
        if (state is TypesLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<OptionCubit, OptionState>(
                builder: (context, optionState) {
                  return MyTitle(
                    text: state.question ?? '',
                    hasBackground: true,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: MyDropDown(
                  data: state.types ?? [],
                  label: state.placeholder ?? '',
                  value: type,
                  onChange: (value) =>
                      context.read<ResultCubit>().onTypeChanged(value),
                ),
              ),
              BlocBuilder<StepNavigationCubit, StepNavigationState>(
                builder: (context, _) {
                  return RectButton(
                      text: 'Next',
                      onPress: type != null
                          ? () => context
                              .read<StepNavigationCubit>()
                              .onNextPressed()
                          : null);
                },
              ),
            ],
          );
        }
        return CircularProgressIndicator(
          color: Theme.of(context).colorScheme.background,
        );
      })),
    );
  }
}
