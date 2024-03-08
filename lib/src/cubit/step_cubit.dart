import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'step_state.dart';

class StepCubit extends Cubit<MyStepState> {
  StepCubit() : super(StepInitial());

  void onOptionChoosen(Option choosenOption) {
    emit(StepOptionChoosen(choosenOption: choosenOption));
  }

  void onNextPressed() {
    switch (state) {
      case StepOptionChoosen():
        if (state.choosenOption == Option.average) {
          emit(NavigateToCountry(choosenOption: state.choosenOption));
        } else if (state.choosenOption == Option.difference) {
          emit(NavigateToLaborHour(choosenOption: state.choosenOption));
        } else {
          emit(NavigateToType(choosenOption: state.choosenOption));
        }
      case NavigateToCountry():
        emit(NavigateToCity(choosenOption: state.choosenOption));
      case NavigateToCity():
        emit(state.choosenOption == Option.m2
            ? NavigateToResult(choosenOption: state.choosenOption)
            : NavigateToSize(choosenOption: state.choosenOption));
      case NavigateToSize():
        emit(state.choosenOption == Option.estimate
            ? NavigateToResult(choosenOption: state.choosenOption)
            : NavigateToType(choosenOption: state.choosenOption));
      case NavigateToType():
        if (state.choosenOption == Option.m2) {
          emit(NavigateToPart(choosenOption: state.choosenOption));
        } else if (state.choosenOption == Option.estimate) {
          emit(NavigateToCountry(choosenOption: state.choosenOption));
        } else {
          emit(NavigateToCompetition(choosenOption: state.choosenOption));
        }
      case NavigateToPart():
        emit(NavigateToCountry(choosenOption: state.choosenOption));
      case NavigateToCompetition():
        emit(NavigateToResult(choosenOption: state.choosenOption));
      case NavigateToResult():
        emit(NavigateToActions(choosenOption: state.choosenOption));

      case NavigateToAmount():
        emit(NavigateToResult(choosenOption: state.choosenOption));
      case NavigateToPercent():
        emit(NavigateToAmount(choosenOption: state.choosenOption));
      case NavigateToAdd():
        emit(NavigateToPercent(choosenOption: state.choosenOption));
      case NavigateToPreliminaries():
        emit(NavigateToAdd(choosenOption: state.choosenOption));
      case NavigateToProfit():
        emit(NavigateToPreliminaries(choosenOption: state.choosenOption));
      case NavigateToLaborRate():
        emit(NavigateToProfit(choosenOption: state.choosenOption));
      case NavigateToMaterial():
        emit(NavigateToLaborRate(choosenOption: state.choosenOption));
      case NavigateToLaborHour():
        emit(NavigateToMaterial(choosenOption: state.choosenOption));
      default:
        break;
    }
  }

  void onPrevPressed() {
    switch (state) {
      case StepOptionChoosen():
        emit(StepInitial());
      case NavigateToLaborHour():
        emit(StepOptionChoosen(choosenOption: state.choosenOption));
      case NavigateToCountry():
        if (state.choosenOption == Option.m2) {
          emit(NavigateToPart(choosenOption: state.choosenOption));
        } else if (state.choosenOption == Option.estimate) {
          emit(NavigateToType(choosenOption: state.choosenOption));
        } else {
          emit(StepOptionChoosen(choosenOption: state.choosenOption));
        }
      case NavigateToCity():
        emit(NavigateToCountry(choosenOption: state.choosenOption));
      case NavigateToSize():
        emit(NavigateToCity(choosenOption: state.choosenOption));
      case NavigateToType():
        emit(state.choosenOption == Option.average
            ? NavigateToSize(choosenOption: state.choosenOption)
            : StepOptionChoosen(choosenOption: state.choosenOption));
      case NavigateToPart():
        emit(NavigateToType(choosenOption: state.choosenOption));
      case NavigateToCompetition():
        emit(NavigateToType(choosenOption: state.choosenOption));
      case NavigateToResult():
        if (state.choosenOption == Option.average) {
          emit(NavigateToCompetition(choosenOption: state.choosenOption));
        } else if (state.choosenOption == Option.m2) {
          emit(NavigateToCity(choosenOption: state.choosenOption));
        } else if (state.choosenOption == Option.estimate) {
          emit(NavigateToSize(choosenOption: state.choosenOption));
        } else {
          emit(NavigateToAmount(choosenOption: state.choosenOption));
        }
      case NavigateToActions():
        emit(NavigateToResult(choosenOption: state.choosenOption));

      case NavigateToAmount():
        emit(NavigateToPercent(choosenOption: state.choosenOption));
      case NavigateToPercent():
        emit(NavigateToAdd(choosenOption: state.choosenOption));
      case NavigateToAdd():
        emit(NavigateToPreliminaries(choosenOption: state.choosenOption));
      case NavigateToPreliminaries():
        emit(NavigateToProfit(choosenOption: state.choosenOption));
      case NavigateToProfit():
        emit(NavigateToLaborRate(choosenOption: state.choosenOption));
      case NavigateToLaborRate():
        emit(NavigateToMaterial(choosenOption: state.choosenOption));
      case NavigateToMaterial():
        emit(NavigateToLaborHour(choosenOption: state.choosenOption));
      default:
        break;
    }
  }

  void onRecalculate() {
    emit(StepOptionChoosen(choosenOption: state.choosenOption));
  }

  void onReset() {
    emit(StepInitial());
  }
}
