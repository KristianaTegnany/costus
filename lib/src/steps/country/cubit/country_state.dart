part of 'country_cubit.dart';

@immutable
sealed class CountryState {
  const CountryState();
}

final class CountryInitial extends CountryState {}

final class CountryChosen extends CountryState {
  const CountryChosen({required this.country});
  final String? country;
}
