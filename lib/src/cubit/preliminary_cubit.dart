import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'preliminary_state.dart';

class PreliminaryCubit extends Cubit<PreliminaryState> {
  PreliminaryCubit() : super(PreliminaryInitial());

  void onPreliminaryChoosen(bool choice) {
    emit(PreliminaryChoosen(addingPreliminary: choice));
  }

  void onPreliminaryChoiceChoosen(bool isAmount) {
    emit(PreliminaryChoiceChoosen(isAmount: isAmount));
  }
}
