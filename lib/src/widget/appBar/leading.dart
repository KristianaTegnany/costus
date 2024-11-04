import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Leading extends StatelessWidget {
  const Leading({super.key, this.isResult, required this.themeState});

  final bool? isResult;
  final ThemeState themeState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepNavigationCubit, StepNavigationState>(
      builder: (context, state) {
      if (state is! StepNavigationInitial) {
        return IconButton(
          color: isResult == true
              ? white
              : themeState.primary,
          iconSize: 40,
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context
              .read<StepNavigationCubit>()
              .onPrevPressed(),
        );
      } else {
        return IconButton(
            color: themeState.primary,
            onPressed: () => Navigator.pushNamed(context, '/'),
            icon: const Icon(Icons.home));
      }
    });
  }
}