part of 'preliminary_cubit.dart';

@immutable
sealed class PreliminaryState {
  const PreliminaryState({this.addingPreliminary});

  final bool? addingPreliminary;
}

final class PreliminaryInitial extends PreliminaryState {}

final class PreliminaryChoosen extends PreliminaryState {
  const PreliminaryChoosen({required super.addingPreliminary});
}

final class PreliminaryChoiceChoosen extends PreliminaryState {
  const PreliminaryChoiceChoosen({required this.isAmount})
      : super(addingPreliminary: true);
  final bool isAmount;
}
