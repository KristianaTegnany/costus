import 'package:costus/src/steps/city/cubit/cities_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityView extends StatelessWidget {
  const CityView({super.key});

  @override
  Widget build(BuildContext context) {
    return StepLayout(child: Center(
      child: BlocBuilder<CitiesCubit, CitiesState>(
        builder: (context, state) {
          if (state is CitiesLoaded) {
            return BlocBuilder<ResultCubit, ResultState>(
                builder: (context, resultState) {
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
                          data: state.cities ?? [],
                          label: state.placeholder ?? '',
                          value: resultState.city,
                          onChange: (value) =>
                              context.read<ResultCubit>().onCityChanged(value),
                        )),
                    BlocBuilder<StepNavigationCubit, StepNavigationState>(
                        builder: (context, _) {
                      return RectButton(
                          text: 'Next',
                          onPress: resultState.city != null
                              ? () => context
                                  .read<StepNavigationCubit>()
                                  .onNextPressed()
                              : null);
                    })
                  ]);
            });
          }
          return CircularProgressIndicator(
            color: Theme.of(context).colorScheme.background,
          );
        },
      ),
    ));
  }
}
