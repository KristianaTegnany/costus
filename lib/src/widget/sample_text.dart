import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SampleText extends StatelessWidget {
  const SampleText({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    final isConnected = FirebaseAuth.instance.currentUser != null;

    return isConnected
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(right: 40, left: 60),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/bubble_icon.png',
                  height: 80,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      return Container(
                        decoration: BoxDecoration(
                          color: state.primary?.withOpacity(kIsWeb ? 0.5 : 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 16,
                            color: white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
