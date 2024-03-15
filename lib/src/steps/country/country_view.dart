import 'package:costus/src/steps/country/cubit/countries_cubit.dart';
import 'package:costus/src/steps/country/cubit/country_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryView extends StatelessWidget {
  const CountryView({super.key});

  @override
  Widget build(BuildContext context) {
    return StepLayout(
      child: Center(
        child: BlocBuilder<CountriesCubit, CountriesState>(
            builder: (context, state) {
          if (state is CountriesLoaded) {
            return BlocBuilder<CountryCubit, CountryState>(
                builder: (context, countryState) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyTitle(
                      text: state.question ?? '',
                      hasBackground: true,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(40),
                        child: MyDropDown(
                          data: state.countries ?? [],
                          label: state.placeholder ?? '',
                          value: countryState is CountryChosen
                              ? countryState.country
                              : null,
                          onChange: (value) => context
                              .read<CountryCubit>()
                              .onCountryChosen(value),
                        )),
                    BlocBuilder<StepNavigationCubit, StepNavigationState>(
                        builder: (context, _) {
                      return RectButton(
                          text: 'Next',
                          onPress: countryState is CountryChosen
                              ? () => context
                                  .read<StepNavigationCubit>()
                                  .onNextPressed()
                              : null);
                    })
                  ]);
            });
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
