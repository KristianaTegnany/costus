part of 'cities_cubit.dart';

@immutable
sealed class CitiesState {
  const CitiesState({this.question, this.placeholder, this.cities});
  final String? question;
  final String? placeholder;
  final List<Map<DataKey, String>>? cities;
}

final class CitiesInitial extends CitiesState {}

final class CountryChanged extends CitiesState {}

final class CitiesLoaded extends CitiesState {
  const CitiesLoaded({super.cities, super.placeholder, super.question});
}
