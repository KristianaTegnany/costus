import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/steps/home/cubit/option_cubit.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/layout/web_layout.dart';
import 'package:costus/src/welcome/widget/why_costus.dart';
import 'package:costus/src/widget/next_button.dart';
import 'package:costus/src/widget/spacer.dart';
import 'package:costus/src/widget/step_image.dart';
import 'package:costus/src/widget/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget(
      {super.key,
      required this.text,
      this.isStart = false,
      required this.onPressed});

  final String text;
  final bool isStart;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isStart ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 15),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: NextButton(text: 'PRESS HERE', onPressed: onPressed),
        )
      ],
    );
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key, required this.goToNext});

  final void Function(Option option) goToNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CSpacer(kIsWeb ? 40 : 20),
          OptionWidget(
              text:
                  'Do you want the average labor rate and material profit you should use for your project? ',
              onPressed: () => goToNext(Option.average)),
          const CSpacer(kIsWeb ? 40 : 20),
          OptionWidget(
              text:
                  'Do you want to input total labor hours & material cost & find out what different labor rates and material profits make to your bottom line?',
              onPressed: () => goToNext(Option.difference)),
          const CSpacer(kIsWeb ? 40 : 20),
          OptionWidget(
              text:
                  'Do you want to find out the m2 chargeable price of your project?',
              onPressed: () => goToNext(Option.m2)),
          const CSpacer(kIsWeb ? 40 : 20),
          OptionWidget(
              text:
                  'Do you have a area size of the project and want a budget cost based on m2?',
              onPressed: () => goToNext(Option.estimate)),
          CSpacer(20),
        ],
      ),
    );
  }
}

class VDecoration extends StatelessWidget {
  const VDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (_, themeState) {
        return MyColoredBox(
          width: 10,
          height: 60,
          color: themeState.primary,
        );
      },
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  goToNext(Option option) {
    context.read<OptionCubit>().onOptionChosen(option);
  }

  @override
  Widget build(BuildContext context) {
    return StepLayout(
      isFirst: true,
      child: SingleChildScrollView(
        child: BlocBuilder<OptionCubit, OptionState>(
          builder: (context, state) {
            return kIsWeb
                ? WebLayout(
                    hasBackground: true,
                    subtitle:
                        'Advanced Data Streams for Mechanical, Electrical, and Building Contractors',
                    children: [
                        const CSpacer(60),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            VDecoration(),
                            CHSpacer(10),
                            SizedBox(
                              width: 375,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CText(
                                    'Four Data Streams',
                                    fontSize: 42,
                                    fontWeight: FontWeight.bold,
                                    height: 1,
                                  ),
                                  CSpacer(10),
                                  CText(
                                    'Select and manage your data streams to input parameters and receive tailored results.',
                                    textAlign: TextAlign.center,
                                    fontSize: 12,
                                  )
                                ],
                              ),
                            ),
                            CHSpacer(10),
                            VDecoration()
                          ],
                        ),
                        const CSpacer(20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: ContentWidget(goToNext: goToNext),
                        ),
                      ])
                : Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        width: kIsWeb ? 400 : double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const StepImage('qa'),
                            ContentWidget(goToNext: goToNext)
                          ],
                        )),
                  );
          },
        ),
      ),
    );
  }
}
