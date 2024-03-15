import 'package:bloc/bloc.dart';
import 'package:costus/src/steps/home/cubit/option_cubit.dart';
import 'package:costus/src/steps/preliminary/cubit/preliminary_cubit.dart';
import 'package:meta/meta.dart';

part 'step_navigation_state.dart';

enum Option { average, difference, m2, estimate }

class StepNavigationCubit extends Cubit<StepNavigationState> {
  StepNavigationCubit(
      {required OptionCubit optionCubit,
      required PreliminaryCubit preliminaryCubit})
      : super(StepNavigationInitial()) {
    optionCubit.stream.listen((event) {
      if (event is OptionChosen) {
        chosenOption = event.chosenOption;
        emit(NavigateToStart());
      }
    });

    preliminaryCubit.stream.listen((event) {
      switch (event) {
        case PreliminaryChosen():
          addingPreliminary = event.addingPreliminary;
          if (addingPreliminary ?? false) {
            emit(NavigateToAdd());
          } else {
            emit(NavigateToResult());
          }
        case PreliminaryChoiceChosen():
          isAmount = event.isAmount;
          if (isAmount ?? false) {
            emit(NavigateToAmount());
          } else {
            emit(NavigateToPercent());
          }
        default:
          break;
      }
    });
  }

  Option? chosenOption;
  bool? addingPreliminary;
  bool? isAmount;

  void onNextPressed() {
    switch (state) {
      case NavigateToStart():
        if (chosenOption == Option.average) {
          emit(NavigateToCountry());
        } else if (chosenOption == Option.difference) {
          emit(NavigateToLaborHour());
        } else {
          emit(NavigateToType());
        }
      case NavigateToCountry():
        emit(NavigateToCity());
      case NavigateToCity():
        emit(chosenOption == Option.m2 ? NavigateToResult() : NavigateToSize());
      case NavigateToSize():
        emit(chosenOption == Option.estimate
            ? NavigateToResult()
            : NavigateToType());
      case NavigateToType():
        if (chosenOption == Option.m2) {
          emit(NavigateToPart());
        } else if (chosenOption == Option.estimate) {
          emit(NavigateToCountry());
        } else {
          emit(NavigateToCompetition());
        }
      case NavigateToPart():
        emit(NavigateToCountry());
      case NavigateToCompetition():
        emit(NavigateToResult());
      case NavigateToResult():
        emit(NavigateToActions());

      case NavigateToAmount():
      case NavigateToPercent():
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
    switch (state) {
      case NavigateToStart():
        emit(StepNavigationInitial());
      case NavigateToLaborHour():
        emit(NavigateToStart());
      case NavigateToCountry():
        if (chosenOption == Option.m2) {
          emit(NavigateToPart());
        } else if (chosenOption == Option.estimate) {
          emit(NavigateToType());
        } else {
          emit(NavigateToStart());
        }
      case NavigateToCity():
        emit(NavigateToCountry());
      case NavigateToSize():
        emit(NavigateToCity());
      case NavigateToType():
        emit(chosenOption == Option.average
            ? NavigateToSize()
            : NavigateToStart());
      case NavigateToPart():
        emit(NavigateToType());
      case NavigateToCompetition():
        emit(NavigateToType());
      case NavigateToResult():
        if (chosenOption == Option.average) {
          emit(NavigateToCompetition());
        } else if (chosenOption == Option.m2) {
          emit(NavigateToCity());
        } else if (chosenOption == Option.estimate) {
          emit(NavigateToSize());
        } else {
          if (addingPreliminary == null || addingPreliminary == false) {
            emit(NavigateToPreliminary());
          } else if (isAmount == null || isAmount == false) {
            emit(NavigateToPercent());
          } else {
            emit(NavigateToAmount());
          }
        }
      case NavigateToActions():
        emit(NavigateToResult());

      case NavigateToAmount():
      case NavigateToPercent():
        emit(NavigateToAdd());
        emit(NavigateToAdd());
      case NavigateToAdd():
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
    emit(NavigateToStart());
  }

  void onReset() {
    emit(StepNavigationInitial());
  }
}
