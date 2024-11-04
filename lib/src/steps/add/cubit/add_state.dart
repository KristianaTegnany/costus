part of 'add_cubit.dart';

@immutable
sealed class AddState {
  const AddState({this.title, this.questionAmount, this.questionPercentage});

  final String? title;
  final String? questionPercentage;
  final String? questionAmount;
}

final class AddInitial extends AddState {}


final class AddLoaded extends AddState {
  const AddLoaded({super.title, super.questionAmount, super.questionPercentage});
}
