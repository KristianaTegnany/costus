import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/home/cubit/option_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/step_view.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeforeResultView extends StatelessWidget {
  const BeforeResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      StepNavigationCubit stepNavigationCubit =
          context.read<StepNavigationCubit>();
      return StepLayout(
        isWebChild: kIsWeb,
        onPress: () => stepNavigationCubit.onNextPressed(),
        child: Center(
          child: Center(
            child: BlocBuilder<OptionCubit, OptionState>(
              builder: (_, state) {
                return state is OptionChosen
                    ? MyTitle(
                        isBold: false,
                        text:
                            "Based on all the selections that you have made, the next screen will show the ${titles[state.chosenOption]!} results.",
                      )
                    : const SizedBox();
              },
            ),
          ),
        ),
      );
    });
  }
}
