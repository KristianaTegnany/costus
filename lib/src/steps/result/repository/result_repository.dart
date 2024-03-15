import 'package:costus/src/steps/result/models/result.dart';

class ResultRepository {
  const ResultRepository(
      {this.country, this.city, this.type, this.size, this.competition});

  final String? country;
  final String? city;
  final String? type;
  final String? size;
  final String? competition;

  ResultRepository copyWith(
      {String? country,
      String? city,
      String? type,
      String? size,
      String? competition}) {
    return ResultRepository(
        country: country ?? this.country,
        city: city ?? this.city,
        type: type ?? this.type,
        size: size ?? this.size,
        competition: competition ?? this.competition);
  }

  Map<Result, String?> get result {
    return {
      Result.country: country,
      Result.city: city,
      Result.type: type,
      Result.size: size,
      Result.competition: competition
    };
  }
}
