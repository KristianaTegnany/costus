import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CircleButton extends StatelessWidget {
  const CircleButton(
      {super.key, this.onPress, this.animate = false, this.disabled = false});

  final void Function()? onPress;
  final bool animate;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final isConnected = FirebaseAuth.instance.currentUser != null;
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return RawMaterialButton(
          onPressed: onPress,
          elevation: 2.0,
          fillColor:
              state.primary?.withOpacity((disabled || onPress == null) ? 0.5 : 1),
          padding: const EdgeInsets.all(10.0),
          shape: const CircleBorder(),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                isConnected
                    ? const SizedBox()
                    : const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Next',
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.bold),
                        ),
                      ),
                const Icon(
                  Icons.arrow_forward,
                  color: white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
