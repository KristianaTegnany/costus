part of 'material_profit_cubit.dart';

@immutable
sealed class MaterialProfitState {
  const MaterialProfitState({this.question, this.placeholder, this.sample});

  final String? question;
  final String? placeholder;
  final String? sample;
}

final class MaterialProfitInitial extends MaterialProfitState {}


final class MaterialProfitLoaded extends MaterialProfitState {
  const MaterialProfitLoaded({super.question, super.placeholder, super.sample});
}
