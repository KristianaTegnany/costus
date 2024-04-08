part of 'result_cubit.dart';

@immutable
class ResultState {
  const ResultState(
      {this.accountType,
      this.country,
      this.city,
      this.type,
      this.size,
      this.competition,
      this.part,
      this.laborHour,
      this.materialCost,
      this.laborRate,
      this.materialProfit,
      this.amount,
      this.percent,
      this.isAmount,
      this.result,
      this.formatedResult,
      this.option});

  final int? accountType;
  final String? country;
  final String? city;
  final String? type;
  final String? size;
  final String? competition;

  final String? part;
  final String? laborHour;
  final String? materialCost;
  final String? laborRate;
  final String? materialProfit;
  final String? amount;
  final String? percent;
  final bool? isAmount;
  final double? result;
  final String? formatedResult;
  final Option? option;

  ResultState empty() {
    return const ResultState();
  }

  ResultState copyWith(
      {int? accountType,
      String? country,
      String? city,
      String? type,
      String? size,
      String? competition,
      String? part,
      String? laborHour,
      String? materialCost,
      String? laborRate,
      String? materialProfit,
      String? amount,
      String? percent,
      bool? isAmount,
      double? result,
      String? formatedResult,
      Option? option}) {
    return ResultState(
        accountType: accountType ?? this.accountType,
        country: country ?? this.country,
        city: country != null ? null : city ?? this.city,
        type: type ?? this.type,
        size: size ?? this.size,
        competition: competition ?? this.competition,
        part: part ?? this.part,
        laborHour: laborHour ?? this.laborHour,
        materialCost: materialCost ?? this.materialCost,
        laborRate: laborRate ?? this.laborRate,
        materialProfit: materialProfit ?? this.materialProfit,
        amount: amount ?? this.amount,
        percent: percent ?? this.percent,
        isAmount: isAmount ?? this.isAmount,
        result: result ?? this.result,
        formatedResult: formatedResult ?? this.formatedResult,
        option: option ?? this.option);
  }
}
