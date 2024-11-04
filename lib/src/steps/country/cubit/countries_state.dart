part of 'countries_cubit.dart';

@immutable
sealed class CountriesState {
  const CountriesState({this.question, this.placeholder, this.sample, this.countries});
  final String? question;
  final String? sample;
  final String? placeholder;
  final List<Map<DataKey, String>>? countries;
}

final class CountriesInitial extends CountriesState {}

final class CountriesLoaded extends CountriesState {
  const CountriesLoaded({super.countries, super.sample, super.placeholder, super.question});
}
