part of 'material_cost_cubit.dart';

@immutable
sealed class MaterialCostState {
  const MaterialCostState({this.question, this.placeholder, this.sample});

  final String? question;
  final String? placeholder;
  final String? sample;
}

final class MaterialCostInitial extends MaterialCostState {}


final class MaterialCostLoaded extends MaterialCostState {
  const MaterialCostLoaded({super.question, super.placeholder, super.sample});
}
