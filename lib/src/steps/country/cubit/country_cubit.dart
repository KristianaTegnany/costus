import 'package:bloc/bloc.dart';
import 'package:costus/src/steps/city/cubit/cities_cubit.dart';
import 'package:costus/src/steps/city/cubit/city_cubit.dart';
import 'package:meta/meta.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit({required this.cityCubit, required this.citiesCubit})
      : super(CountryInitial());

  final CityCubit cityCubit;
  final CitiesCubit citiesCubit;

  void onCountryChosen(String? country) {
    cityCubit.emit(CityInitial());
    citiesCubit.onCountryChanged(country ?? '');
    emit(CountryChosen(country: country));
  }
}
