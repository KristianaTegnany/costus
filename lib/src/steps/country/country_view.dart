import 'package:costus/src/steps/country/cubit/countries_cubit.dart';
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

class CountryView extends StatelessWidget {
  const CountryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ResultCubit resultCubit = context.read<ResultCubit>();
      ResultState resultState = context.watch<ResultCubit>().state;
      StepNavigationCubit stepNavigationCubit =
          context.read<StepNavigationCubit>();

      return BlocProvider(
        create: (context) => CountriesCubit(),
        child: StepLayout(
            isWebChild: kIsWeb,
            onPress: () => stepNavigationCubit.onNextPressed(),
            buttonDisabled: resultState.country == null,
            child: Center(
              child: BlocBuilder<CountriesCubit, CountriesState>(
                  builder: (context, state) {
                if (state is CountriesLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const StepImage('country'),
                      MyTitle(
                        text: state.question ?? '',
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                          child: MyDropDown(
                            data: state.countries ?? [],
                            label: state.placeholder ?? '',
                            value: resultState.country,
                            onChange: (value) =>
                                resultCubit.onCountryChanged(value),
                          )),
                      SampleText(text: state.sample ?? ''),
                    ],
                  );
                }
                return const CircularProgressIndicator(
                  color: background,
                );
              }),
            )),
      );
    });
  }
}
