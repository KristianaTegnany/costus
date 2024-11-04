import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.text, required this.onPressed});

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return TextButton.icon(
            onPressed: onPressed,
            label: Text(
              text,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: state.primary),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.only(left: 10, right: 5),
            ),
            iconAlignment: IconAlignment.end,
            icon: Icon(
              Icons.arrow_circle_right,
              size: 40,
              color: state.primary,
            ));
      },
    );
  }
}
