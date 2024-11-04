part of 'option_cubit.dart';

@immutable
sealed class OptionState {
  const OptionState();
}

final class OptionInitial extends OptionState {}

final class OptionChosen extends OptionState {
  const OptionChosen({required this.chosenOption});

  final Option chosenOption;
}
