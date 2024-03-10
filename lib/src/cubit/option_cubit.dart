import 'package:bloc/bloc.dart';
import 'package:costus/src/cubit/step_navigation_cubit.dart';
import 'package:meta/meta.dart';

part 'option_state.dart';

class OptionCubit extends Cubit<OptionState> {
  OptionCubit() : super(OptionInitial());

  void onOptionChoosen(Option choosenOption) {
    emit(OptionChoosen(choosenOption: choosenOption));
  }
}
