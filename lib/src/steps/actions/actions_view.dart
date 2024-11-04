import 'package:costus/src/steps/actions/widget/content.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/layout/web_layout.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/widget/spacer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ActionsView extends StatelessWidget {
  const ActionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return StepLayout(
        isAction: true,
        child: kIsWeb
            ? SingleChildScrollView(
                child: WebLayout(
                    title: 'End Page',
                    subtitle:
                        'You can share, print, email, recalculate the results or select new method',
                    children: [
                    const CSpacer(40),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: border, width: 2),
                          borderRadius: BorderRadius.circular(10),
                          color: white),
                      width: 600,
                      alignment: Alignment.center,
                      child: const ActionContentWidget(),
                    )
                  ]))
            :  SingleChildScrollView(child: const ActionContentWidget()));
  }
}
