part of 'option_cubit.dart';

@immutable
sealed class OptionState {}

final class OptionInitial extends OptionState {}

final class OptionChoosen extends OptionState {
  OptionChoosen({required this.choosenOption});

  final Option choosenOption;
}
