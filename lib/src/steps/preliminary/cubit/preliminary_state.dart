part of 'preliminary_cubit.dart';

@immutable
sealed class PreliminaryState {
  const PreliminaryState({this.addingPreliminary});

  final bool? addingPreliminary;
}

final class PreliminaryInitial extends PreliminaryState {}

final class PreliminaryChosen extends PreliminaryState {
  const PreliminaryChosen({required super.addingPreliminary});
}

final class PreliminaryChoiceChosen extends PreliminaryState {
  const PreliminaryChoiceChosen({required this.isAmount})
      : super(addingPreliminary: true);
  final bool isAmount;
}
