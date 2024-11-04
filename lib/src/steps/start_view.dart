import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/utils/account/update_account_type.dart';
import 'package:costus/src/utils/subscription/subscription_dialog.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/welcome/widget/button_image.dart';
import 'package:costus/src/widget/title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const Map<Option, String> titles = {
  Option.average: "Average Rate Calculation",
  Option.difference: "Difference Rate",
  Option.m2: "m2 Rate",
  Option.estimate: "Estimate on m2 Rate"
};

class StartView extends StatefulWidget {
  const StartView(
      {super.key, required this.chosenOption, required this.onPress});

  final Option? chosenOption;
  final void Function() onPress;

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  void goToStep(bool disabled, String value) {
    final int type = int.parse(value.split(":")[0]);
    if (disabled) {
      onChangeAccountType(context, value, () {
        updateAccountType(type, () {
          context.read<ResultCubit>().onAccountTypeChanged(type);
          widget.onPress();
        });
      });
    } else {
      context.read<ResultCubit>().onAccountTypeChanged(type);
      widget.onPress();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isConnected = FirebaseAuth.instance.currentUser != null;
    return StepLayout(
      title: titles[widget.chosenOption],
      isStart: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height - 80,
            width: kIsWeb ? 400 : double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Column(
                  children: [
                    MyTitle(
                      text: 'Let’s get started!',
                      lg: true,
                      isPrimary: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 40),
                      child: Text(
                        'Unlock the potential of your financial management journey with our Average Rate Calculation feature.\nTake charge of your budgeting goals and make informed decisions to optimize your spending habits effortlessly.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, themeState) {
                  return Column(
                    children: [
                      Text(
                        "Contractor's Category Sample Rates",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: themeState.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<ResultCubit, ResultState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ButtonImage(
                                  color: secondary,
                                  text: 'Mechanical',
                                  image: 'mechanical2',
                                  onPress: () {
                                    context
                                        .read<ThemeCubit>()
                                        .changeTheme(CategTheme.secondary);
                                    goToStep(
                                        isConnected && state.accountType != 1,
                                        "1:1");
                                  }),
                              ButtonImage(
                                  color: primary,
                                  text: 'Electrical',
                                  image: 'electrical2',
                                  onPress: () {
                                    context
                                        .read<ThemeCubit>()
                                        .changeTheme(CategTheme.primary);
                                    goToStep(
                                        isConnected && state.accountType != 2,
                                        "2:2");
                                  }),
                              ButtonImage(
                                  color: tertiary,
                                  text: 'Building',
                                  image: 'building2',
                                  onPress: () {
                                    context
                                        .read<ThemeCubit>()
                                        .changeTheme(CategTheme.tertiary);
                                    goToStep(
                                        isConnected && state.accountType != 3,
                                        "3:3");
                                  }),
                            ],
                          );
                        },
                      )
                    ],
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
