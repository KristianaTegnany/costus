import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/labor_hour/cubit/labor_hour_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/widget/my_textfield.dart';
import 'package:costus/src/widget/sample_text.dart';
import 'package:costus/src/widget/step_image.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaborHourView extends StatelessWidget {
  const LaborHourView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      StepNavigationCubit stepNavigationCubit =
          context.read<StepNavigationCubit>();

      return BlocProvider(
        create: (context) => LaborHourCubit(),
        child: StepLayout(
          isWebChild: kIsWeb,
          onPress: () => stepNavigationCubit.onNextPressed(),
          child: Center(child: BlocBuilder<LaborHourCubit, LaborHourState>(
            builder: (context, hourState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const StepImage('labor_hour'),
                  MyTitle(
                    text: hourState.question ?? '',
                  ),
                  BlocBuilder<ResultCubit, ResultState>(
                    builder: (context, state) {
                      return MyTextField(
                          value: state.laborHour,
                          isNumber: true,
                          label: hourState.placeholder ?? '',
                          onChange: (value) {
                            context
                                .read<ResultCubit>()
                                .onLaborHourChanged(value);
                          });
                    },
                  ),
                  SampleText(text: hourState.sample ?? ''),
                ],
              );
            },
          )),
        ),
      );
    });
  }
}
