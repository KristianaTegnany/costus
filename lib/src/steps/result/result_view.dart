import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/steps/home/cubit/option_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/layout/web_layout.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/steps/result/widget/result_clip.dart';
import 'package:costus/src/steps/result/widget/text_result.dart';
import 'package:costus/src/steps/start_view.dart';
import 'package:costus/src/steps/widget/step_button.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isConnected = FirebaseAuth.instance.currentUser != null;
    return BlocBuilder<ResultCubit, ResultState>(
      buildWhen: (previous, current) =>
          previous.formatedResult != current.formatedResult,
      builder: (context, state) {
        final selections = state.option == Option.difference
            ? [
                'Labor hour: ${state.laborHour}',
                'Material cost: £${state.materialCost}',
                'Labor rate: £${state.laborRate}',
                'Material profit: ${state.materialProfit}',
                state.isAmount == true
                    ? 'Amount: £${state.amount}'
                    : 'Percentage: ${state.percent}'
              ]
            : [
                'Country: ${state.country?.split(':')[0][0].toUpperCase()}${state.country?.split(':')[0].substring(1)}',
                'City: ${state.city?.split(':')[0]}',
                'Type of construction: ${state.type?.split(':')[0][0].toUpperCase()}${state.type?.split(':')[0].substring(1)}',
                'Type of building: ${state.part?.split(':')[0]}',
                'Size: ${state.size?.split(':')[0]}',
                'Competition level: ${state.competition?.split(':')[0]}',
              ];
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (_, themeState) {
            return Container(
              color: themeState.background,
              child: Stack(
                children: [
                  kIsWeb
                      ? const SizedBox()
                      : ClipPath(
                          clipper: ResultClip(),
                          child: ColoredBox(
                            color: themeState.primary ?? primary,
                            child: const SizedBox(
                              height: 200,
                              width: double.infinity,
                            ),
                          ),
                        ),
                  Container(
                    width: kIsWeb ? 500 : double.infinity,
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: border, width: 2),
                        borderRadius: BorderRadius.circular(10),
                        color: white),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/${themeState.theme.name}/success.png',
                                width: kIsWeb
                                    ? 100
                                    : MediaQuery.of(context).size.width / 4,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Success!',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: themeState.primary),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Based On ${isConnected ? 'Your' : 'Sample'} Selections Of:',
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: selections.length,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      selections[index],
                                      textAlign: TextAlign.center,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 20,
                                      child: Divider(
                                        indent:
                                            MediaQuery.sizeOf(context).width / 4,
                                        endIndent:
                                            MediaQuery.sizeOf(context).width / 4,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: List.generate(20, (index) {
                              return Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: Container(
                                    height: 1,
                                    color: lightGrey,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        BlocBuilder<OptionCubit, OptionState>(
                          builder: (_, optionState) {
                            if (optionState is OptionChosen) {
                              context
                                  .read<ResultCubit>()
                                  .setFormatedResult(optionState.chosenOption);
                              final result = state.formatedResult ?? '';
                              if (result.isEmpty) {
                                return const SizedBox();
                              }
              
                              final isAverage =
                                  optionState.chosenOption == Option.average;
                              final isM2 = optionState.chosenOption == Option.m2;
              
                              return Column(children: [
                                Text(
                                  'The ${isAverage ? 'Average Rate Should' : isM2 ? 'Cost Per M2 Should' : 'Total Estimate Will'} Be:',
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                isAverage
                                    ? Column(
                                        children: [
                                          TextResult(
                                            label: 'Labour / man hour\n',
                                            value: result.split('/')[0],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextResult(
                                            label: 'Material at cost\n',
                                            value: result.split('/')[1],
                                          ),
                                        ],
                                      )
                                    : Text('£$result',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: themeState.primary)),
                                const SizedBox(
                                  height: 20,
                                ),
                                onPressed != null
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: StepButton(
                                            text: 'Next', onPressed: onPressed!),
                                      )
                                    : const SizedBox()
                              ]);
                            }
                            return const CircularProgressIndicator(
                              color: background,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ResultView extends StatelessWidget {
  const ResultView({
    super.key,
    required this.chosenOption,
  });
  final Option? chosenOption;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      StepNavigationCubit stepNavigationCubit =
          context.read<StepNavigationCubit>();

      return StepLayout(
        title: titles[chosenOption],
        isResult: true,
        onPress: () => stepNavigationCubit.onNextPressed(),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: kIsWeb
              ? WebLayout(
                  title: 'Final Result ${titles[chosenOption]}',
                  subtitle:
                      'This is a final ${titles[chosenOption]} result according to the information you provided',
                  children: [
                      ContentWidget(
                          onPressed: stepNavigationCubit.onNextPressed)
                    ])
              : const ContentWidget(),
        ),
      );
    });
  }
}
