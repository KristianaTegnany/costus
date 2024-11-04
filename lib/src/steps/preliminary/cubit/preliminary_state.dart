part of 'preliminary_cubit.dart';

@immutable
sealed class PreliminaryState {
  const PreliminaryState({this.addingPreliminary, this.title, this.questionNo, this.questionYes});

  final bool? addingPreliminary;
  final String? title;
  final String? questionYes;
  final String? questionNo;
}

final class PreliminaryInitial extends PreliminaryState {}

final class PreliminaryLoaded extends PreliminaryState {
  const PreliminaryLoaded({super.title, super.questionNo, super.questionYes});
}

final class PreliminaryChosen extends PreliminaryState {
  PreliminaryChosen({required super.addingPreliminary, required PreliminaryState state}) : super(title: state.title, questionNo: state.questionNo, questionYes: state.questionYes);
}

final class PreliminaryChoiceChosen extends PreliminaryState {
  PreliminaryChoiceChosen({required this.isAmount, required PreliminaryState state})
      : super(addingPreliminary: true, title: state.title, questionNo: state.questionNo, questionYes: state.questionYes);
  final bool isAmount;
}
