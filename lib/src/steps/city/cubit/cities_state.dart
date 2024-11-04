part of 'cities_cubit.dart';

@immutable
sealed class CitiesState {
  const CitiesState({this.question, this.placeholder, this.sample, this.cities});
  final String? question;
  final String? placeholder;
  final String? sample;
  final List<Map<DataKey, String>>? cities;
}

final class CitiesInitial extends CitiesState {}

final class CountryChanged extends CitiesState {}

final class CitiesLoaded extends CitiesState {
  const CitiesLoaded({super.cities, super.sample, super.placeholder, super.question});
}
