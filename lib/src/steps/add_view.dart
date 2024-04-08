import 'package:costus/src/steps/preliminary/cubit/preliminary_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddView extends StatelessWidget {
  const AddView({super.key});

  @override
  Widget build(BuildContext context) {
    return StepLayout(
      child: Center(child: BlocBuilder<PreliminaryCubit, PreliminaryState>(
        builder: (context, _) {
          return BlocBuilder<ResultCubit, ResultState>(
            builder: (resultContext, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MyTitle(
                    text: "Add by % or amount?",
                    hasBackground: true,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  RectButton(
                      text: '%',
                      onPress: () {
                        context
                            .read<PreliminaryCubit>()
                            .onPreliminaryChoiceChosen(false);
                        resultContext
                            .read<ResultCubit>()
                            .onIsAmountChanged(false);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  RectButton(
                      text: 'Amount',
                      onPress: () {
                        context
                            .read<PreliminaryCubit>()
                            .onPreliminaryChoiceChosen(true);
                        resultContext
                            .read<ResultCubit>()
                            .onIsAmountChanged(true);
                      }),
                ],
              );
            },
          );
        },
      )),
    );
  }
}
