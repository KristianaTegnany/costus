import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';

class RectButton extends StatelessWidget {
  const RectButton(
      {super.key,
      this.isPrimary = true,
      this.disabled = false,
      required this.text,
      this.onPress});

  final String text;
  final bool disabled;
  final bool isPrimary;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    final double opacity = disabled || onPress == null ? 0.7 : 1;

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return FilledButton(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(isPrimary
                  ? state.primary?.withOpacity(opacity)
                  : white.withOpacity(opacity)),
              elevation: const WidgetStatePropertyAll(2),
              foregroundColor: const WidgetStatePropertyAll(primary),
              shape: WidgetStatePropertyAll(BeveledRectangleBorder(
                  side: BorderSide(
                      color: white.withOpacity(0.2),
                      width: isPrimary ? 0 : 0.5))),
              padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(
                  horizontal: 40, vertical: kIsWeb ? 20 : 10))),
          onPressed: onPress,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isPrimary
                    ? white.withOpacity(opacity)
                    : state.primary?.withOpacity(opacity)),
          ),
        );
      },
    );
  }
}
