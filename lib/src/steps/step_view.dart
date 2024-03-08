import 'package:costus/src/cubit/step_cubit.dart';
import 'package:costus/src/steps/actions_view.dart';
import 'package:costus/src/steps/add_view.dart';
import 'package:costus/src/steps/amount_view.dart';
import 'package:costus/src/steps/city_view.dart';
import 'package:costus/src/steps/competition_view.dart';
import 'package:costus/src/steps/country_view.dart';
import 'package:costus/src/steps/home_view.dart';
import 'package:costus/src/steps/labor_hour_view.dart';
import 'package:costus/src/steps/labor_rate_view.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/material_view.dart';
import 'package:costus/src/steps/part_view.dart';
import 'package:costus/src/steps/percent_view.dart';
import 'package:costus/src/steps/preliminaries_view.dart';
import 'package:costus/src/steps/profit_view.dart';
import 'package:costus/src/steps/result_view.dart';
import 'package:costus/src/steps/size_view.dart';
import 'package:costus/src/steps/start_view.dart';
import 'package:costus/src/steps/type_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepView extends StatelessWidget {
  const StepView({super.key});

  static const routeName = '/step';

  @override
  Widget build(BuildContext context) {
    return StepLayout(
      isChild: false,
      child: Center(
        child: BlocBuilder<StepCubit, MyStepState>(
          builder: (context, state) {
            Widget page = const SizedBox();
            if (state is StepInitial) {
              page = const HomeView();
            }
            if (state is StepOptionChoosen) {
              page = StartView(
                choosenOption: state.choosenOption,
                onPress: () => context.read<StepCubit>().onNextPressed(),
              );
            } else if (state is NavigateToCountry) {
              page = const CountryView();
            } else if (state is NavigateToCity) {
              page = const CityView();
            } else if (state is NavigateToSize) {
              page = const SizeView();
            } else if (state is NavigateToType) {
              page = const TypeView();
            } else if (state is NavigateToPart) {
              page = const PartView();
            } else if (state is NavigateToCompetition) {
              page = const CompetitionView();
            } else if (state is NavigateToResult) {
              page = const ResultView();
            } else if (state is NavigateToActions) {
              page = const ActionsView();
            } else if (state is NavigateToLaborHour) {
              page = const LaborHourView();
            } else if (state is NavigateToMaterial) {
              page = const MaterialView();
            } else if (state is NavigateToLaborRate) {
              page = const LaborRateView();
            } else if (state is NavigateToProfit) {
              page = const ProfitView();
            } else if (state is NavigateToPreliminaries) {
              page = const PreliminariesView();
            } else if (state is NavigateToAdd) {
              page = const AddView();
            } else if (state is NavigateToPercent) {
              page = const PercentView();
            } else if (state is NavigateToAmount) {
              page = const AmountView();
            }
            return PopScope(
                canPop: state is StepInitial,
                onPopInvoked: (didPop) {
                  if (didPop) {
                    return;
                  }
                  context.read<StepCubit>().onPrevPressed();
                },
                child: page);
          },
        ),
      ),
    );
  }
}
