import 'dart:ui';

import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/utils/account/update_account_type.dart';
import 'package:costus/src/utils/subscription/subscription_dialog.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/welcome/widget/button_image.dart';
import 'package:costus/src/widget/spacer.dart';
import 'package:costus/src/widget/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeMobileView extends StatefulWidget {
  const WelcomeMobileView({super.key});

  @override
  State<WelcomeMobileView> createState() => _WelcomeMobileViewState();
}

class _WelcomeMobileViewState extends State<WelcomeMobileView> {

  void goToStep(bool disabled, String value) {
    final int type = int.parse(value.split(":")[0]);
    if (disabled) {
      onChangeAccountType(context, value, () {
        updateAccountType(type, () {
          context.read<ResultCubit>().onAccountTypeChanged(type);
          Navigator.pushNamed(context, '/step');
        });
      });
    } else {
      context.read<ResultCubit>().onAccountTypeChanged(type);
      Navigator.pushNamed(context, '/step');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isConnected = FirebaseAuth.instance.currentUser != null;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CSpacer(20),
        Container(
          color: primary,
          padding: const EdgeInsets.all(10),
          child: const CText(
            "About Us",
            textAlign: TextAlign.center,
            color: white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        Stack(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/about.jpg',
                  width: double.infinity,
                  color: primary.withOpacity(0.4),
                  colorBlendMode: BlendMode.darken,
                ),
                Positioned.fill(
                    child: ColoredBox(
                  color: black.withOpacity(0.3),
                ))
              ],
            ),
            const Positioned.fill(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, bottom: 60),
                  child: CText(
                    'At Costus, we empower contractors with comprehensive technical data tailored to their needs. Enabling informed decision-making for mechanical, electrical, and building projects. We provide innovative solutions that enhance project efficiency and accurancy.',
                    textAlign: TextAlign.center,
                    fontSize: 16,
                    color: white,
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
                  filter:
                      ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          background,
                          primary,
                          primary,
                          primary.withOpacity(0.1)
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
        ),
        const CSpacer(40),
        const CText(
          "Contractor's Category",
          textAlign: TextAlign.center,
          color: primary,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        const CSpacer(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<ResultCubit, ResultState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
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
                            isConnected &&
                                state.accountType != 1,
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
                            isConnected &&
                                state.accountType != 2,
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
                            isConnected &&
                                state.accountType != 3,
                            "3:3");
                      }),
                ],
              );
            },
          ),
        ),
        const CSpacer(40),
        Stack(
          children: [
            Stack(
              children: [
                Container(
                  color: primary,
                  height: 220,
                ),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/images/mobile.png',
                    height: 200,
                  ),
                ))
              ],
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 2 / 3,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CText(
                        'Costus delivers essential technical insights to revolutionize your project planning and execution.',
                        color: white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            ),
          ],
        ),
        const CSpacer(20),
      ],
    );
  }
}