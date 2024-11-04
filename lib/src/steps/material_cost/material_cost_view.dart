import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/material_cost/cubit/material_cost_cubit.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/widget/my_textfield.dart';
import 'package:costus/src/widget/sample_text.dart';
import 'package:costus/src/widget/step_image.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialView extends StatelessWidget {
  const MaterialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      StepNavigationCubit stepNavigationCubit =
          context.read<StepNavigationCubit>();
      return BlocProvider(
        create: (context) => MaterialCostCubit(),
        child: StepLayout(
          isWebChild: kIsWeb,
          onPress: () => stepNavigationCubit.onNextPressed(),
          child:
              Center(child: BlocBuilder<MaterialCostCubit, MaterialCostState>(
            builder: (context, costState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const StepImage('material_cost'),
                  MyTitle(
                    text: costState.question ?? '',
                  ),
                  BlocBuilder<ResultCubit, ResultState>(
                    builder: (context, state) {
                      return MyTextField(
                          value: state.materialCost,
                          isCurrency: true,
                          label: costState.placeholder ?? '',
                          onChange: (value) {
                            context
                                .read<ResultCubit>()
                                .onMaterialCostChanged(value);
                          });
                    },
                  ),
                  SampleText(text: costState.sample ?? ''),
                ],
              );
            },
          )),
        ),
      );
    });
  }
}
