import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ActionType { print, email, share, recalculate, newMethod }

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key, this.isInline = false, required this.type, this.onPress});

  final ActionType type;
  final bool isInline;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: border, width: 2))),
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: onPress,
        child: Opacity(
          opacity: onPress != null ? 1 : 0.5,
          child: Row(
            children: [
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return Image.asset(
                    'assets/images/${state.theme.name}/${type.name}.png',
                    height: 40,
                    width: 40,
                  );
                },
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                type.name
                    .toUpperCase()
                    .replaceAll('NEWMETHOD', 'SELECT NEW METHOD'),
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
