import 'package:bloc/bloc.dart';
import 'package:costus/src/cubit/option_cubit.dart';
import 'package:costus/src/cubit/preliminary_cubit.dart';
import 'package:meta/meta.dart';

part 'step_navigation_state.dart';

enum Option { average, difference, m2, estimate }

class StepNavigationCubit extends Cubit<StepNavigationState> {
  StepNavigationCubit(
      {required OptionCubit optionCubit,
      required PreliminaryCubit preliminaryCubit})
      : super(StepNavigationInitial()) {
    optionCubit.stream.listen((event) {
      if (event is OptionChoosen) {
        choosenOption = event.choosenOption;
        emit(NavigateToStart());
      }
    });

    preliminaryCubit.stream.listen((event) {
      switch (event) {
        case PreliminaryChoosen():
          addingPreliminary = event.addingPreliminary;
          if (addingPreliminary ?? false) {
            emit(NavigateToAdd());
          } else {
            emit(NavigateToResult());
          }
        case PreliminaryChoiceChoosen():
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

  Option? choosenOption;
  bool? addingPreliminary;
  bool? isAmount;

  void onNextPressed() {
    switch (state) {
      case NavigateToStart():
        if (choosenOption == Option.average) {
          emit(NavigateToCountry());
        } else if (choosenOption == Option.difference) {
          emit(NavigateToLaborHour());
        } else {
          emit(NavigateToType());
        }
      case NavigateToCountry():
        emit(NavigateToCity());
      case NavigateToCity():
        emit(
            choosenOption == Option.m2 ? NavigateToResult() : NavigateToSize());
      case NavigateToSize():
        emit(choosenOption == Option.estimate
            ? NavigateToResult()
            : NavigateToType());
      case NavigateToType():
        if (choosenOption == Option.m2) {
          emit(NavigateToPart());
        } else if (choosenOption == Option.estimate) {
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
        if (choosenOption == Option.m2) {
          emit(NavigateToPart());
        } else if (choosenOption == Option.estimate) {
          emit(NavigateToType());
        } else {
          emit(NavigateToStart());
        }
      case NavigateToCity():
        emit(NavigateToCountry());
      case NavigateToSize():
        emit(NavigateToCity());
      case NavigateToType():
        emit(choosenOption == Option.average
            ? NavigateToSize()
            : NavigateToStart());
      case NavigateToPart():
        emit(NavigateToType());
      case NavigateToCompetition():
        emit(NavigateToType());
      case NavigateToResult():
        if (choosenOption == Option.average) {
          emit(NavigateToCompetition());
        } else if (choosenOption == Option.m2) {
          emit(NavigateToCity());
        } else if (choosenOption == Option.estimate) {
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
