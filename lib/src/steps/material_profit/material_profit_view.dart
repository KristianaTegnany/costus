import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/material_profit/cubit/material_profit_cubit.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/widget/my_textfield.dart';
import 'package:costus/src/widget/sample_text.dart';
import 'package:costus/src/widget/step_image.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfitView extends StatelessWidget {
  const ProfitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      StepNavigationCubit stepNavigationCubit =
          context.read<StepNavigationCubit>();
      return BlocProvider(
        create: (context) => MaterialProfitCubit(),
        child: StepLayout(
          isWebChild: kIsWeb,
          onPress: () => stepNavigationCubit.onNextPressed(),
          child: Center(
              child: BlocBuilder<MaterialProfitCubit, MaterialProfitState>(
            builder: (context, profitState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const StepImage('material_profit'),
                  MyTitle(
                    text: profitState.question ?? '',
                  ),
                  BlocBuilder<ResultCubit, ResultState>(
                    builder: (context, state) {
                      return MyTextField(
                          value: state.materialProfit,
                          isNumber: true,
                          label: profitState.placeholder ?? '',
                          onChange: (value) {
                            context
                                .read<ResultCubit>()
                                .onMaterialProfitChanged(value);
                          });
                    },
                  ),
                  SampleText(text: profitState.sample ?? ''),
                ],
              );
            },
          )),
        ),
      );
    });
  }
}
