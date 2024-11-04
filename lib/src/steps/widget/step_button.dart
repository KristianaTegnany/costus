import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/widget/spacer.dart';
import 'package:costus/src/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepButton extends StatelessWidget {
  const StepButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isNext = true});

  final String text;
  final VoidCallback onPressed;
  final bool isNext;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return InkWell(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: themeState.primary,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.only(
                left: isNext == true ? 20 : 0, right: isNext == true ? 0 : 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              textDirection:
                  isNext == true ? TextDirection.ltr : TextDirection.rtl,
              children: [
                CText(
                  text,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                const CHSpacer(10),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFC5DCEB),
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                        isNext == true
                            ? Icons.chevron_right
                            : Icons.chevron_left,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
