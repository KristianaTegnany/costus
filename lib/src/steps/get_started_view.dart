import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/steps/layout/web_layout.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/widget/step_button.dart';
import 'package:costus/src/welcome/widget/title_section.dart';
import 'package:costus/src/widget/spacer.dart';
import 'package:costus/src/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Item extends StatelessWidget {
  const Item(
      {super.key,
      required this.number,
      required this.text,
      this.isLast = false});

  final String number;
  final String text;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    Alignment alignment =
        isLast == true ? Alignment.centerRight : Alignment.centerLeft;
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: alignment,
                child: SizedBox(
                  width: 400,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: isLast == true ? 0 : 40,
                        right: isLast == true ? 40 : 0),
                    child: CText(
                      text,
                      textAlign:
                          isLast == true ? TextAlign.end : TextAlign.start,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: alignment,
              child: BlocBuilder<ThemeCubit, ThemeState>(
                builder: (_, themeState) {
                  return CText(
                    number,
                    fontSize: 80,
                    height: 0.9,
                    fontWeight: FontWeight.w900,
                    color: themeState.primary?.withOpacity(0.5),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return StepLayout(
        isFirst: true,
        child: SingleChildScrollView(
            child: WebLayout(
                hasBackground: true,
                title: 'Let’s Get Started',
                subtitle: 'Learn How It Works and Start Your Path to Success',
                children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Column(
                  children: [
                    const TitleSection(
                      title: 'Learn Our Process',
                      subtitle: 'How It Works',
                      description:
                          'Getting started is easy! Follow our step-by-step guide to understand the process.',
                    ),
                    const CSpacer(40),
                    const Item(
                      number: '01',
                      text:
                          'Provide the given information according\n to your selected data stream.',
                    ),
                    const Item(
                      number: '02',
                      text:
                          'Select a data stream from given four\n data streams.',
                      isLast: true,
                    ),
                    const Item(
                      number: '03',
                      text:
                          'After getting the results, you can share your result\n via email, print, recalculate or select new method.',
                    ),
                    const Item(
                      number: '04',
                      text:
                          'Finally get the results based on your\n selected data stream and provided data.',
                      isLast: true,
                    ),
                    StepButton(
                      text: 'START NOW',
                      onPressed: () => Navigator.pushNamed(context, '/step'),
                    )
                  ],
                ),
              )
            ])));
  }
}
