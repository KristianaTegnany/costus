part of 'competitions_cubit.dart';

@immutable
sealed class CompetitionsState {
  const CompetitionsState({this.question, this.placeholder, this.sample, this.competitions});
  final String? question;
  final String? placeholder;
  final String? sample;
  final List<Map<DataKey, String>>? competitions;
}

final class CompetitionsInitial extends CompetitionsState {}

final class CompetitionsLoaded extends CompetitionsState {
  const CompetitionsLoaded(
      {super.competitions, super.placeholder, super.sample, super.question});
}
