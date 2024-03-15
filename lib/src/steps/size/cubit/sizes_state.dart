part of 'sizes_cubit.dart';

@immutable
sealed class SizesState {
  const SizesState(
      {this.question, this.questionEstimate, this.placeholder, this.sizes});
  final String? question;
  final String? questionEstimate;
  final String? placeholder;
  final List<Map<DataKey, String>>? sizes;
}

final class SizesInitial extends SizesState {}

final class SizesLoaded extends SizesState {
  const SizesLoaded(
      {super.sizes, super.placeholder, super.questionEstimate, super.question});
}
