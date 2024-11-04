import 'package:bloc/bloc.dart';
import 'package:costus/src/steps/city/cubit/cities_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/part/cubit/part_cubit.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'option_state.dart';

class OptionCubit extends Cubit<OptionState> {
  OptionCubit(
      {required this.resultCubit,
      required this.citiesCubit,
      required this.partsCubit})
      : super(OptionInitial());

  final ResultCubit resultCubit;
  final CitiesCubit citiesCubit;
  final PartsCubit partsCubit;

  void onOptionChosen(Option chosenOption) {
    emit(OptionChosen(chosenOption: chosenOption));
    if (FirebaseAuth.instance.currentUser == null) {
      switch (chosenOption) {
        case Option.average:
        case Option.estimate:
        case Option.m2:
          resultCubit.emit(resultCubit.state.copyWith(country: "england:0"));
          citiesCubit.onCountryChanged("england:0");
          resultCubit.emit(resultCubit.state
              .copyWith(city: "London:0", type: "commercial:0"));
          partsCubit.onTypeChanged("commercial:0");
          resultCubit.emit(resultCubit.state.copyWith(
              part: "Offices - Fit Out:348:247:250",
              size: chosenOption == Option.estimate ? "1500" : "Medium:0",
              competition: "Medium:0"));
        case Option.difference:
          resultCubit.emit(resultCubit.state.copyWith(
              laborHour: "1000",
              materialCost: "50000",
              laborRate: "40",
              materialProfit: "20",
              percent: "10",
              amount: "10000"));
        default:
          break;
      }
    }
  }
}
