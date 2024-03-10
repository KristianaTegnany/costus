part of 'step_navigation_cubit.dart';

@immutable
sealed class StepNavigationState {}

final class StepNavigationInitial extends StepNavigationState {}

final class NavigateToStart extends StepNavigationState {}

final class NavigateToCountry extends StepNavigationState {}

final class NavigateToCity extends StepNavigationState {}

final class NavigateToSize extends StepNavigationState {}

final class NavigateToType extends StepNavigationState {}

final class NavigateToPart extends StepNavigationState {}

final class NavigateToCompetition extends StepNavigationState {}

final class NavigateToResult extends StepNavigationState {}

final class NavigateToActions extends StepNavigationState {}

final class NavigateToLaborHour extends StepNavigationState {}

final class NavigateToMaterial extends StepNavigationState {}

final class NavigateToLaborRate extends StepNavigationState {}

final class NavigateToProfit extends StepNavigationState {}

final class NavigateToPreliminary extends StepNavigationState {}

final class NavigateToAdd extends StepNavigationState {}

final class NavigateToPercent extends StepNavigationState {}

final class NavigateToAmount extends StepNavigationState {}
