part of 'amount_cubit.dart';

@immutable
sealed class AmountState {
  const AmountState({this.question, this.placeholder, this.sample});

  final String? question;
  final String? placeholder;
  final String? sample;
}

final class AmountInitial extends AmountState {}


final class AmountLoaded extends AmountState {
  const AmountLoaded({super.question, super.placeholder, super.sample});
}
