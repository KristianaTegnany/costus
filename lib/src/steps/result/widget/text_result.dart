import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextResult extends StatelessWidget {
  const TextResult({super.key, required this.label, this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return value == null
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.all(5.0),
            child: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return RichText(
                  textAlign: TextAlign.center,
                  text:
                      TextSpan(style: const TextStyle(color: grey), children: [
                    TextSpan(text: label),
                    TextSpan(
                        text: value,
                        style: TextStyle(
                            color: state.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))
                  ]),
                );
              },
            ),
          );
  }
}
