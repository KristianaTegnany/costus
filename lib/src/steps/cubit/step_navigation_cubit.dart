import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:costus/src/steps/home/cubit/option_cubit.dart';
import 'package:costus/src/steps/preliminary/cubit/preliminary_cubit.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:meta/meta.dart';

part 'step_navigation_state.dart';

enum Option { average, difference, m2, estimate }

class StepNavigationCubit extends Cubit<StepNavigationState> {
  StepNavigationCubit(
      {required this.optionCubit,
      required PreliminaryCubit preliminaryCubit,
      required this.resultCubit})
      : super(StepNavigationInitial()) {
    _optionSubscription = optionCubit.stream.listen((event) {
      if (event is OptionChosen) {
        chosenOption = event.chosenOption;
        step = 0;
        switch (event.chosenOption) {
          case Option.difference:
            nbStep = 5;
            emit(NavigateToLaborHour());
          default:
            emit(NavigateToCountry());
            nbStep = 6;
        }
      }
    });

    _preliminarySubscription = preliminaryCubit.stream.listen((event) {
      switch (event) {
        case PreliminaryChosen():
          addingPreliminary = event.addingPreliminary;
          if (addingPreliminary ?? false) {
            nbStep = 7;
            emit(NavigateToAdd());
            step = 5;
          } else {
            emit(NavigateToBeforeResult());
            nbStep = 5;
            step = null;
          }
        case PreliminaryChoiceChosen():
          isAmount = event.isAmount;
          if (isAmount ?? false) {
            emit(NavigateToAmount());
          } else {
            emit(NavigateToPercent());
          }
          step = 6;
        default:
          break;
      }
    });
  }

  final ResultCubit resultCubit;
  final OptionCubit optionCubit;

  Option? chosenOption;
  bool? addingPreliminary;
  bool? isAmount;
  int? nbStep;
  int? step;

  void onNextPressed() {
    if (step != null) {
      step = step! + 1;
    }
    switch (state) {
      case NavigateToCountry():
        emit(NavigateToCity());
      case NavigateToCity():
        emit(NavigateToType());
      case NavigateToSize():
        emit(NavigateToCompetition());
      case NavigateToType():
        emit(NavigateToPart());
      case NavigateToPart():
        emit(NavigateToSize());
      case NavigateToResult():
        emit(NavigateToActions());

      case NavigateToCompetition():
      case NavigateToAmount():
      case NavigateToPercent():
        emit(NavigateToBeforeResult());
        step = null;
      case NavigateToBeforeResult():
        emit(NavigateToResult());
      case NavigateToProfit():
        emit(NavigateToPreliminary());
      case NavigateToLaborRate():
        emit(NavigateToProfit());
      case NavigateToMaterial():
        emit(NavigateToLaborRate());
      case NavigateToLaborHour():
        emit(NavigateToMaterial());
      default:
        break;
    }
  }

  void onPrevPressed() {
    if (step != null && step! > 0) {
      step = step! - 1;
    }
    switch (state) {
      case NavigateToLaborHour():
      case NavigateToCountry():
        emit(StepNavigationInitial());
        step = null;
      case NavigateToCity():
        emit(NavigateToCountry());
      case NavigateToSize():
        emit(NavigateToPart());
      case NavigateToType():
        emit(NavigateToCity());
      case NavigateToPart():
        emit(NavigateToType());
      case NavigateToCompetition():
        emit(NavigateToSize());
      case NavigateToBeforeResult():
        if (chosenOption == Option.difference) {
          if (addingPreliminary == null || addingPreliminary == false) {
            emit(NavigateToPreliminary());
          } else if (isAmount == null || isAmount == false) {
            emit(NavigateToPercent());
          } else {
            emit(NavigateToAmount());
          }
        } else {
          emit(NavigateToCompetition());
        }
        step = nbStep! - 1;

      case NavigateToResult():
        emit(NavigateToBeforeResult());
      case NavigateToActions():
        emit(NavigateToResult());
      case NavigateToAmount():
      case NavigateToPercent():
        emit(NavigateToAdd());
      case NavigateToAdd():
        nbStep = 5;
        emit(NavigateToPreliminary());
      case NavigateToPreliminary():
        emit(NavigateToProfit());
      case NavigateToProfit():
        emit(NavigateToLaborRate());
      case NavigateToLaborRate():
        emit(NavigateToMaterial());
      case NavigateToMaterial():
        emit(NavigateToLaborHour());
      default:
        break;
    }
  }

  void onRecalculate() {
    Option option = resultCubit.state.option!;
    resultCubit.emit(resultCubit.state.empty());
    optionCubit.onOptionChosen(option);
  }

  void onReset() {
    resultCubit.emit(resultCubit.state.empty());
    emit(StepNavigationInitial());
  }

  StreamSubscription<OptionState>? _optionSubscription;
  StreamSubscription<PreliminaryState>? _preliminarySubscription;

  @override
  Future<void> close() {
    _optionSubscription?.cancel();
    _preliminarySubscription?.cancel();
    return super.close();
  }
}
