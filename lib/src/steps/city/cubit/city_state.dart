part of 'city_cubit.dart';

@immutable
sealed class CityState {
  const CityState();
}

final class CityInitial extends CityState {}

final class CityChosen extends CityState {
  const CityChosen({required this.city});
  final String? city;
}
