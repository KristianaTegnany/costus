import 'package:costus/src/steps/before_result_view.dart';
import 'package:costus/src/steps/get_started_view.dart';
import 'package:costus/src/steps/home/cubit/option_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/actions/actions_view.dart';
import 'package:costus/src/steps/add/add_view.dart';
import 'package:costus/src/steps/amount/amount_view.dart';
import 'package:costus/src/steps/city/city_view.dart';
import 'package:costus/src/steps/competition/competition_view.dart';
import 'package:costus/src/steps/country/country_view.dart';
import 'package:costus/src/steps/home/home_view.dart';
import 'package:costus/src/steps/labor_hour/labor_hour_view.dart';
import 'package:costus/src/steps/labor_rate/labor_rate_view.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/layout/web_step_layout.dart';
import 'package:costus/src/steps/material_cost/material_cost_view.dart';
import 'package:costus/src/steps/part/part_view.dart';
import 'package:costus/src/steps/percent/percent_view.dart';
import 'package:costus/src/steps/preliminary/preliminaries_view.dart';
import 'package:costus/src/steps/material_profit/material_profit_view.dart';
import 'package:costus/src/steps/result/result_view.dart';
import 'package:costus/src/steps/size/size_view.dart';
import 'package:costus/src/steps/type/type_view.dart';
import 'package:costus/src/welcome/welcome_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const Map<Option, String> titles = {
  Option.average: "Average Rate Calculation",
  Option.difference: "Difference Rate",
  Option.m2: "m2 Rate",
  Option.estimate: "Estimate on m2 Rate"
};

class StepView extends StatelessWidget {
  const StepView({super.key});

  static const routeName = '/step';

  @override
  Widget build(BuildContext context) {
    return StepLayout(
      isChild: false,
      child: Center(
        child: BlocBuilder<StepNavigationCubit, StepNavigationState>(
          builder: (context, state) {
            Widget page = const SizedBox();
            if (state is StepNavigationInitial) {
              final args = ModalRoute.of(context)?.settings.arguments;
              if (args != null && (args as StepArgs).isGetstarted == true) {
                page = const GetStarted();
              } else {
                page = const HomeView();
              }
            } else if (state is NavigateToResult) {
              page = BlocBuilder<OptionCubit, OptionState>(
                  builder: (context, state) {
                return ResultView(
                  chosenOption: (state as OptionChosen).chosenOption,
                );
              });
            } else if (state is NavigateToActions) {
              page = const ActionsView();
            } else if (kIsWeb) {
              Widget child = page = const BeforeResultView();
              if (state is NavigateToCountry) {
                child = const CountryView();
              } else if (state is NavigateToCity) {
                child = const CityView();
              } else if (state is NavigateToSize) {
                child = const SizeView();
              } else if (state is NavigateToType) {
                child = const TypeView();
              } else if (state is NavigateToPart) {
                child = const PartView();
              } else if (state is NavigateToCompetition) {
                child = const CompetitionView();
              } else if (state is NavigateToLaborHour) {
                child = const LaborHourView();
              } else if (state is NavigateToMaterial) {
                child = const MaterialView();
              } else if (state is NavigateToLaborRate) {
                child = const LaborRateView();
              } else if (state is NavigateToProfit) {
                child = const ProfitView();
              } else if (state is NavigateToPreliminary) {
                child = const PreliminariesView();
              } else if (state is NavigateToAdd) {
                child = const AddView();
              } else if (state is NavigateToPercent) {
                child = const PercentView();
              } else if (state is NavigateToAmount) {
                child = const AmountView();
              }
              page = BlocBuilder<OptionCubit, OptionState>(
                builder: (_, state) {
                  final Option option = (state as OptionChosen).chosenOption;
                  final String? title = titles[option];
                  return WebStepLayout(
                      title: '$title Page',
                      subtitle:
                          'If you want to get ${title?.toLowerCase()}, then you have to provide below important information',
                      isDifference: option == Option.difference,
                      child: child);
                },
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
            } else if (state is NavigateToLaborHour) {
              page = const LaborHourView();
            } else if (state is NavigateToMaterial) {
              page = const MaterialView();
            } else if (state is NavigateToLaborRate) {
              page = const LaborRateView();
            } else if (state is NavigateToProfit) {
              page = const ProfitView();
            } else if (state is NavigateToPreliminary) {
              page = const PreliminariesView();
            } else if (state is NavigateToAdd) {
              page = const AddView();
            } else if (state is NavigateToPercent) {
              page = const PercentView();
            } else if (state is NavigateToAmount) {
              page = const AmountView();
            } else if (state is NavigateToBeforeResult) {
              page = const BeforeResultView();
            }
            return PopScope(
                canPop: state is StepNavigationInitial,
                onPopInvokedWithResult: (didPop, dynamic) {
                  if (didPop) {
                    return;
                  }
                  context.read<StepNavigationCubit>().onPrevPressed();
                },
                child: page);
          },
        ),
      ),
    );
  }
}
