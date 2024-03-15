part of 'result_cubit.dart';

@immutable
class ResultState {
  const ResultState(
      {this.country, this.city, this.type, this.size, this.competition});

  final String? country;
  final String? city;
  final String? type;
  final String? size;
  final String? competition;

  ResultState copyWith(
      {String? country,
      String? city,
      String? type,
      String? size,
      String? competition}) {
    return ResultState(
        country: country ?? this.country,
        city: city ?? this.city,
        type: type ?? this.type,
        size: size ?? this.size,
        competition: competition ?? this.competition);
  }
}
