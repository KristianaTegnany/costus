import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TitleBar extends StatelessWidget {
  const TitleBar(
      {super.key,
      this.title,
      this.isResult,
      required this.isWelcome,
      required this.themeState});

  final String? title;
  final bool? isResult;
  final bool isWelcome;
  final ThemeState themeState;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: kIsWeb ? () => Navigator.pushNamed(context, '/') : null,
      child: kIsWeb
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/images/logo-white.png',
                width: 150,
              ),
            )
          : title != null
              ? Text(title!,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: isResult == true ? white : null,
                  ))
              : (isWelcome
                  ? Image.asset(
                      'assets/images/logo.png',
                      width: 200,
                    )
                  : BlocBuilder<StepNavigationCubit, StepNavigationState>(
                      builder: (stepContext, _) {
                        return (stepContext.read<StepNavigationCubit>().step !=
                                null
                            ? SizedBox(
                                height: 10,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: stepContext
                                      .read<StepNavigationCubit>()
                                      .nbStep!,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: themeState.primary?.withOpacity(
                                            index >
                                                    stepContext
                                                        .read<
                                                            StepNavigationCubit>()
                                                        .step!
                                                ? 0.2
                                                : 1),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : BlocBuilder<ThemeCubit, ThemeState>(
                                builder: (context, state) {
                                  return Image.asset(
                                    'assets/images/logo.png',
                                    width: 200,
                                    color: state.primary,
                                  );
                                },
                              ));
                      },
                    )),
    );
  }
}
