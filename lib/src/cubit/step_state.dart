part of 'step_cubit.dart';

enum Option { average, difference, m2, estimate }

@immutable
sealed class MyStepState {
  const MyStepState({this.choosenOption});
  final Option? choosenOption;
}

final class StepInitial extends MyStepState {}

final class StepOptionChoosen extends MyStepState {
  const StepOptionChoosen({required super.choosenOption});
}

final class NavigateToCountry extends MyStepState {
  const NavigateToCountry({required super.choosenOption});
}

final class NavigateToCity extends MyStepState {
  const NavigateToCity({required super.choosenOption});
}

final class NavigateToSize extends MyStepState {
  const NavigateToSize({required super.choosenOption});
}

final class NavigateToType extends MyStepState {
  const NavigateToType({required super.choosenOption});
}

final class NavigateToPart extends MyStepState {
  const NavigateToPart({required super.choosenOption});
}

final class NavigateToCompetition extends MyStepState {
  const NavigateToCompetition({required super.choosenOption});
}

final class NavigateToResult extends MyStepState {
  const NavigateToResult({required super.choosenOption});
}

final class NavigateToActions extends MyStepState {
  const NavigateToActions({required super.choosenOption});
}

final class NavigateToLaborHour extends MyStepState {
  const NavigateToLaborHour({required super.choosenOption});
}

final class NavigateToMaterial extends MyStepState {
  const NavigateToMaterial({required super.choosenOption});
}

final class NavigateToLaborRate extends MyStepState {
  const NavigateToLaborRate({required super.choosenOption});
}

final class NavigateToProfit extends MyStepState {
  const NavigateToProfit({required super.choosenOption});
}

final class NavigateToPreliminaries extends MyStepState {
  const NavigateToPreliminaries({required super.choosenOption});
}

final class NavigateToAdd extends MyStepState {
  const NavigateToAdd({required super.choosenOption});
}

final class NavigateToPercent extends MyStepState {
  const NavigateToPercent({required super.choosenOption});
}

final class NavigateToAmount extends MyStepState {
  const NavigateToAmount({required super.choosenOption});
}
