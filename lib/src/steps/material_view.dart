import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/widget/my_textfield.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialView extends StatelessWidget {
  const MaterialView({super.key});

  @override
  Widget build(BuildContext context) {
    return StepLayout(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const MyTitle(
            text: "What is the material cost?",
            hasBackground: true,
          ),
          BlocBuilder<ResultCubit, ResultState>(
            builder: (context, state) {
              return MyTextField(
                  value: state.materialCost,
                  isCurrency: true,
                  label: "Material cost",
                  onChange: (value) {
                    context.read<ResultCubit>().onMaterialCostChanged(value);
                  });
            },
          ),
          BlocBuilder<StepNavigationCubit, StepNavigationState>(
              builder: (context, state) {
            return RectButton(
                text: 'Next',
                onPress: () =>
                    context.read<StepNavigationCubit>().onNextPressed());
          })
        ],
      )),
    );
  }
}
