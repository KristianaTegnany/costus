part of 'part_cubit.dart';

@immutable
sealed class PartsState {
  const PartsState({this.question, this.placeholder, this.sample, this.parts});
  final String? question;
  final String? placeholder;
  final String? sample;
  final List<Map<DataKey, String>>? parts;
}

final class PartsInitial extends PartsState {}

final class CountryChanged extends PartsState {}

final class PartsLoaded extends PartsState {
  const PartsLoaded({super.parts, super.placeholder, super.sample, super.question});
}
