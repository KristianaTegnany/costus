part of 'sizes_cubit.dart';

@immutable
sealed class SizesState {
  const SizesState(
      {this.question, this.questionEstimate, this.placeholder, this.sample, this.sampleEstimate, this.sizes});
  final String? question;
  final String? questionEstimate;
  final String? placeholder;
  final String? sample;
  final String? sampleEstimate;
  
  final List<Map<DataKey, String>>? sizes;
}

final class SizesInitial extends SizesState {}

final class SizesLoaded extends SizesState {
  const SizesLoaded(
      {super.sizes, super.placeholder, super.questionEstimate, super.sample, super.sampleEstimate, super.question});
}
