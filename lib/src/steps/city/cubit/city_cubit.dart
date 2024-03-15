import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit() : super(CityInitial());

  void onCityChosen(String? city) {
    emit(CityChosen(city: city));
  }
}
