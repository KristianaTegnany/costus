part of 'competition_cubit.dart';

@immutable
sealed class CompetitionState {
  const CompetitionState();
}

final class CompetitionInitial extends CompetitionState {}

final class CompetitionChosen extends CompetitionState {
  const CompetitionChosen({required this.competition});
  final String? competition;
}
