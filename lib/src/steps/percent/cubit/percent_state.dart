part of 'percent_cubit.dart';

@immutable
sealed class PercentState {
  const PercentState({this.question, this.placeholder, this.sample});

  final String? question;
  final String? placeholder;
  final String? sample;
}

final class PercentInitial extends PercentState {}


final class PercentLoaded extends PercentState {
  const PercentLoaded({super.question, super.placeholder, super.sample});
}
