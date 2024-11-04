import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTitle extends StatelessWidget {
  const MyTitle(
      {super.key,
      required this.text,
      this.isBold = true,
      this.lg = false,
      this.isPrimary = false});

  final String text;
  final bool lg;
  final bool isPrimary;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: lg == true ? 24 : 20,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: isPrimary ? state.primary : black),
          );
        },
      ),
    );
  }
}
