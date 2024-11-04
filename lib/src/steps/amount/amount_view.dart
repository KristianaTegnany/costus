import 'package:costus/src/steps/amount/cubit/amount_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/widget/my_textfield.dart';
import 'package:costus/src/widget/sample_text.dart';
import 'package:costus/src/widget/step_image.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmountView extends StatelessWidget {
  const AmountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      StepNavigationCubit stepNavigationCubit =
          context.read<StepNavigationCubit>();
      return BlocProvider(
        create: (context) => AmountCubit(),
        child: StepLayout(
          isWebChild: kIsWeb,
          onPress: () => stepNavigationCubit.onNextPressed(),
          child: Center(child: BlocBuilder<AmountCubit, AmountState>(
            builder: (context, amountState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const StepImage('amount'),
                  MyTitle(
                    text: amountState.question ?? '',
                  ),
                  BlocBuilder<ResultCubit, ResultState>(
                    builder: (context, state) {
                      return MyTextField(
                          value: state.amount,
                          isCurrency: true,
                          label: amountState.placeholder ?? '',
                          onChange: (value) {
                            context.read<ResultCubit>().onAmountChanged(value);
                          });
                    },
                  ),
                  SampleText(text: amountState.sample ?? ''),
                ],
              );
            },
          )),
        ),
      );
    });
  }
}
