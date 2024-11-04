part of 'labor_rate_cubit.dart';

@immutable
sealed class LaborRateState {
  const LaborRateState({this.question, this.placeholder, this.sample});

  final String? question;
  final String? placeholder;
  final String? sample;
}

final class LaborRateInitial extends LaborRateState {}


final class LaborRateLoaded extends LaborRateState {
  const LaborRateLoaded({super.question, super.placeholder, super.sample});
}
