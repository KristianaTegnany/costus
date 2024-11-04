import 'package:costus/src/steps/city/cubit/cities_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:costus/src/widget/sample_text.dart';
import 'package:costus/src/widget/step_image.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityView extends StatelessWidget {
  const CityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ResultCubit resultCubit = context.read<ResultCubit>();
      ResultState resultState = context.watch<ResultCubit>().state;
      StepNavigationCubit stepNavigationCubit =
          context.read<StepNavigationCubit>();

      return StepLayout(
          isWebChild: kIsWeb,
          onPress: () => stepNavigationCubit.onNextPressed(),
          buttonDisabled: resultState.city == null,
          child: Center(
            child: BlocBuilder<CitiesCubit, CitiesState>(
              builder: (context, state) {
                if (state is CitiesLoaded) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const StepImage('city'),
                        MyTitle(
                          text: state.question ?? '',
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: MyDropDown(
                              data: state.cities ?? [],
                              label: state.placeholder ?? '',
                              value: resultState.city,
                              onChange: (value) =>
                                  resultCubit.onCityChanged(value),
                            )),
                        SampleText(
                            text:
                                state.sample ?? ''),
                      ]);
                }
                return const CircularProgressIndicator(
                  color: background,
                );
              },
            ),
          ));
    });
  }
}
