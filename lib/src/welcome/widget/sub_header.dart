import 'dart:ui';

import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/widget/text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubHeader extends StatelessWidget {
  const SubHeader({super.key, this.title, required this.subtile});

  final String? title;
  final String subtile;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Stack(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/about.jpg',
                  width: double.infinity,
                  height: kIsWeb ? 400 : null,
                  fit: BoxFit.cover,
                  color: themeState.primary?.withOpacity(0.4),
                  colorBlendMode: BlendMode.darken,
                ),
                Positioned.fill(
                    child: ColoredBox(
                  color: black.withOpacity(0.3),
                ))
              ],
            ),
            Positioned.fill(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: kIsWeb ? 80 : 20,
                      right: kIsWeb ? 80 : 20,
                      bottom: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      title != null
                          ? CText(
                              title!,
                              textAlign: TextAlign.center,
                              fontSize: kIsWeb ? 36 : 20,
                              color: white,
                            )
                          : CText(
                              subtile,
                              textAlign: TextAlign.center,
                              fontSize: kIsWeb ? 22 : 16,
                              color: white,
                            ),
                      title != null
                          ? CText(
                              subtile,
                              textAlign: TextAlign.center,
                              color: white,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          background,
                          themeState.primary ?? primary,
                          themeState.primary ?? primary,
                          (themeState.primary ?? primary).withOpacity(0.1),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
