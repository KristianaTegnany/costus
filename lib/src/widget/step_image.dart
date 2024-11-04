import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepImage extends StatelessWidget {
  const StepImage(this.image, {super.key, this.hasDecoration = false});

  final String image;
  final bool hasDecoration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return Stack(alignment: Alignment.center, children: [
            kIsWeb && hasDecoration == false
                ? const SizedBox()
                : Image.asset(
                    'assets/images/${state.theme.name}/bg4.png',
                  ),
            image.isNotEmpty
                ? Image.asset(
                    'assets/images/${state.theme.name}/$image.png',
                    height: 100,
                  )
                : const SizedBox(),
          ]);
        },
      ),
    );
  }
}
