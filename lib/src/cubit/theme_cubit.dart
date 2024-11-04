import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeInitial());

  changeTheme(CategTheme theme) {
    emit(ThemeChanged(theme: theme));
  }
}
