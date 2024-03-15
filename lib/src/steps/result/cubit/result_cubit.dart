import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(const ResultState());

  void onCountryChanged(String country) {
    emit(state.copyWith(country: country));
  }

  void onCityChanged(String city) {
    emit(state.copyWith(city: city));
  }

  void onTypeChanged(String type) {
    emit(state.copyWith(type: type));
  }

  void onCompetitionChanged(String comp) {
    emit(state.copyWith(competition: comp));
  }
}
