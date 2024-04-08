import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:costus/src/steps/city/cubit/cities_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/part/cubit/part_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit({required this.citiesCubit, required this.partsCubit})
      : super(const ResultState()) {
    getAccountType().then((data) => emit(state.copyWith(accountType: data)));
  }

  final CitiesCubit citiesCubit;
  final PartsCubit partsCubit;

  Future<int?> getAccountType() async {
    final DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return user['accountType'];
  }

  void onAccountTypeChanged(int? value) {
    final int? lastAccountType = state.accountType;
    emit(state.copyWith(accountType: value));
    if (state.option != null &&
        state.formatedResult != null &&
        value != lastAccountType) {
      setFormatedResult(state.option!);
    }
  }

  void onCountryChanged(String? country) {
    emit(state.copyWith(country: country, city: null));
    citiesCubit.onCountryChanged(country);
  }

  void onCityChanged(String? city) {
    emit(state.copyWith(city: city));
  }

  void onTypeChanged(String? type) {
    emit(state.copyWith(type: type, part: null));
    partsCubit.onTypeChanged(type);
  }

  void onSizeChanged(String? size) {
    emit(state.copyWith(size: size));
  }

  void onCompetitionChanged(String? comp) {
    emit(state.copyWith(competition: comp));
  }

  void onPartChanged(String? part) {
    getAccountType()
        .then((data) => {emit(state.copyWith(part: part, accountType: data))});
  }

  void onLaborHourChanged(String? laborHour) {
    emit(state.copyWith(laborHour: laborHour));
  }

  void onMaterialCostChanged(String? materialCost) {
    emit(state.copyWith(materialCost: materialCost));
  }

  void onLaborRateChanged(String? laborRate) {
    emit(state.copyWith(laborRate: laborRate));
  }

  void onMaterialProfitChanged(String? materialProfit) {
    emit(state.copyWith(materialProfit: materialProfit));
  }

  void onAmountChanged(String? amount) {
    emit(state.copyWith(amount: amount));
  }

  void onPercentChanged(String? percent) {
    emit(state.copyWith(percent: percent));
  }

  void onIsAmountChanged(bool? isAmount) {
    emit(state.copyWith(isAmount: isAmount));
  }

  double getResult(Option option) {
    double result = 0;
    if (option == Option.difference) {
      result = double.parse(state.laborHour ?? '0') *
              double.parse(state.laborRate ?? '0') +
          double.parse(state.materialCost ?? '0') *
              (1 + double.parse(state.materialProfit ?? '0') / 100);
      if (state.isAmount == false && state.percent != null) {
        result = result * (1 + double.parse(state.percent ?? '0') / 100);
      } else if (state.isAmount == true && state.amount != null) {
        result += double.parse(state.amount ?? '0');
      }
    } else if (option == Option.average) {
      result = double.parse(state.country?.split(':')[1] ?? '0') +
          double.parse(state.city?.split(':')[1] ?? '0') +
          double.parse(state.type?.split(':')[1] ?? '0') +
          double.parse(state.size?.split(':')[1] ?? '0') +
          double.parse(state.competition?.split(':')[1] ?? '0');
    } else if (option == Option.m2) {
      result =
          double.parse(state.part?.split(':')[state.accountType ?? 1] ?? '0');
    } else if (option == Option.estimate) {
      result =
          double.parse(state.part?.split(':')[state.accountType ?? 1] ?? '0') *
              double.parse(state.size ?? '0');
    }

    emit(state.copyWith(result: result));
    return result;
  }

  void setFormatedResult(Option option) {
    final double result = getResult(option);
    String formatedResult = '';
    if ([Option.difference, Option.m2, Option.estimate].contains(option)) {
      final currFormat = NumberFormat("#,##0.00", "en_US");
      formatedResult = currFormat.format(result);
    } else if (option == Option.average) {
      switch (result) {
        case -1:
          formatedResult = '£32.00/10%';
        case 0:
          formatedResult = '£35.00/15%';
        case 1:
          formatedResult = '£40.00/20%';
      }
    }

    emit(state.copyWith(formatedResult: formatedResult, option: option));
  }
}
