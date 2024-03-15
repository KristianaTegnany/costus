import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'preliminary_state.dart';

class PreliminaryCubit extends Cubit<PreliminaryState> {
  PreliminaryCubit() : super(PreliminaryInitial());

  void onPreliminaryChosen(bool choice) {
    emit(PreliminaryChosen(addingPreliminary: choice));
  }

  void onPreliminaryChoiceChosen(bool isAmount) {
    emit(PreliminaryChoiceChosen(isAmount: isAmount));
  }
}
