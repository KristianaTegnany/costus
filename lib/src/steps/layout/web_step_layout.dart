import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/layout/web_layout.dart';
import 'package:costus/src/steps/widget/step_button.dart';
import 'package:costus/src/welcome/widget/why_costus.dart';
import 'package:costus/src/widget/spacer.dart';
import 'package:costus/src/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepItem extends StatelessWidget {
  const StepItem(
      {super.key,
      this.isFirst,
      this.isLast,
      required this.checked,
      required this.text});

  final bool? isFirst;
  final bool? isLast;
  final bool checked;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (_, themeState) {
              return Row(
                children: [
                  isFirst == true
                      ? const CHSpacer(20)
                      : MyColoredBox(
                          width: 20,
                          height: 4,
                          color: themeState.primary,
                        ),
                  Stack(
                    children: [
                      ClipOval(
                          child: Opacity(
                              opacity: checked ? 1 : 0.5,
                              child: MyColoredBox(
                                width: 40,
                                color: themeState.primary,
                              ))),
                      Positioned.fill(
                        child: Center(
                          child: Image.asset(
                            'assets/images/check.png',
                            width: 25,
                            height: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                  isLast == true
                      ? const CHSpacer(20)
                      : MyColoredBox(
                          width: 20,
                          height: 4,
                          color: themeState.primary,
                        ),
                ],
              );
            },
          ),
          const CSpacer(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CText(
              text,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class WebStepLayout extends StatelessWidget {
  const WebStepLayout(
      {super.key,
      required this.child,
      this.title,
      required this.subtitle,
      this.isDifference = false});

  final Widget child;
  final String? title;
  final String subtitle;
  final bool isDifference;

  @override
  Widget build(BuildContext context) {
    final List<List<String>> steps = [
      [
        "Country Name",
        "City Name",
        "Construction Type",
        "Building Type",
        "Size of Project",
        "Competition Type",
      ],
      [
        "Labour Hours",
        "Material Cost",
        "Labour Rate",
        "Profit On Material",
        "Add Preliminaries",
        "Percentage Or Amount",
        "Add Value",
      ],
    ];

    return StepLayout(
      child: SingleChildScrollView(
        child: SizedBox(
          width: 800,
          child: WebLayout(title: title, subtitle: subtitle, children: [
            const CSpacer(60),
            BlocBuilder<StepNavigationCubit, StepNavigationState>(
              builder: (stepContext, _) {
                final int nbItems =
                    stepContext.read<StepNavigationCubit>().nbStep!;
                return stepContext.read<StepNavigationCubit>().step != null
                    ? SizedBox(
                        height: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: nbItems,
                          itemBuilder: (context, index) {
                            final currentSteps = steps[isDifference ? 1 : 0];
                            return StepItem(
                                isFirst: index == 0,
                                isLast: index == nbItems - 1,
                                text: currentSteps[index],
                                checked: index <=
                                    stepContext
                                        .read<StepNavigationCubit>()
                                        .step!);
                          },
                        ),
                      )
                    : const SizedBox();
              },
            ),
            const CSpacer(20),
            SizedBox(width: 500, child: child),
            const CSpacer(60),
            SizedBox(
              width: 400,
              child: BlocBuilder<StepNavigationCubit, StepNavigationState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StepButton(
                          text: 'Return',
                          isNext: false,
                          onPressed: context
                              .read<StepNavigationCubit>()
                              .onPrevPressed),
                      isDifference &&
                              [4, 5].contains(
                                  context.read<StepNavigationCubit>().step)
                          ? const SizedBox()
                          : StepButton(
                              text: 'Next',
                              onPressed: context
                                  .read<StepNavigationCubit>()
                                  .onNextPressed),
                    ],
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
