import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'competition_state.dart';

class CompetitionCubit extends Cubit<CompetitionState> {
  CompetitionCubit() : super(CompetitionInitial());

  void onCompetitionChosen(String? competition) {
    emit(CompetitionChosen(competition: competition));
  }
}
