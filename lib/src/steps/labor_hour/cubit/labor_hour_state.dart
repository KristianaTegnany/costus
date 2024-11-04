part of 'labor_hour_cubit.dart';

@immutable
sealed class LaborHourState {
  const LaborHourState({this.question, this.placeholder, this.sample});

  final String? question;
  final String? placeholder;
  final String? sample;
}

final class LaborHourInitial extends LaborHourState {}


final class LaborHourLoaded extends LaborHourState {
  const LaborHourLoaded({super.question, super.placeholder, super.sample});
}
