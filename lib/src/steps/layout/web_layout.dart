import 'dart:ui';

import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/utils/account/update_account_type.dart';
import 'package:costus/src/utils/subscription/subscription_dialog.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/welcome/widget/button_image.dart';
import 'package:costus/src/welcome/widget/sub_header.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/spacer.dart';
import 'package:costus/src/widget/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebLayout extends StatefulWidget {
  const WebLayout(
      {super.key,
      required this.children,
      this.title,
      required this.subtitle,
      this.hasBackground,
      this.background});

  final List<Widget> children;
  final String? title;
  final String subtitle;
  final bool? hasBackground;
  final Color? background;

  @override
  State<WebLayout> createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayout> {
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
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (_, themeState) {
        return ColoredBox(
          color: white,
          child: Center(
              child: SizedBox(
            child: Column(
              children: [
                widget.hasBackground != true
                    ? Column(
                        children: [
                          const CSpacer(80),
                          CText(
                            widget.title!,
                            color: themeState.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                            height: 1.2,
                            textAlign: TextAlign.center,
                          ),
                          const CSpacer(20),
                          Center(
                            child: SizedBox(
                              width: 500,
                              child: CText(
                                widget.subtitle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      )
                    : SubHeader(title: widget.title, subtile: widget.subtitle),
                const CSpacer(20),
                SizedBox(
                  width: 800,
                  child: Column(
                    children: widget.children,
                  ),
                ),
                const CSpacer(80),
                const CText(
                  'Subscribe For 6, 9 Or 12 Months',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                const CSpacer(20),
                const Center(
                  child: SizedBox(
                    width: 500,
                    child: CText(
                      "Choose a subscription plan that best suits your project's needs. With options for 6, 9, or 12 months, you can enjoy continuous support and insights to enhance your workflow.",
                      fontSize: 12,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const CSpacer(40),
                RectButton(
                  text: 'Subscribe now',
                  isPrimary: false,
                  onPress: () {},
                ),
                const CSpacer(80),
                const CText(
                  'Contractor’s Categories',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                const CSpacer(20),
                const Center(
                  child: CText(
                    "There are three gateways to subscription area.",
                    fontSize: 12,
                    textAlign: TextAlign.center,
                  ),
                ),
                const CSpacer(40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<ResultCubit, ResultState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonImage(
                              color: secondary,
                              text: 'Mechanical',
                              image: 'mechanical2',
                              isBig: true,
                              onPress: () {
                                context
                                    .read<ThemeCubit>()
                                    .changeTheme(CategTheme.secondary);
                                goToStep(isConnected && state.accountType != 1,
                                    "1:1");
                              }),
                          const CHSpacer(40),
                          ButtonImage(
                              color: primary,
                              text: 'Electrical',
                              image: 'electrical2',
                              isBig: true,
                              onPress: () {
                                context
                                    .read<ThemeCubit>()
                                    .changeTheme(CategTheme.primary);
                                goToStep(isConnected && state.accountType != 2,
                                    "2:2");
                              }),
                          const CHSpacer(40),
                          ButtonImage(
                              color: tertiary,
                              text: 'Building',
                              image: 'building2',
                              isBig: true,
                              onPress: () {
                                context
                                    .read<ThemeCubit>()
                                    .changeTheme(CategTheme.tertiary);
                                goToStep(isConnected && state.accountType != 3,
                                    "3:3");
                              }),
                        ],
                      );
                    },
                  ),
                ),
                const CSpacer(40),
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            themeState.primary ?? primary,
                            background,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                ),
                ColoredBox(
                  color: themeState.primary ?? primary,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            color: Colors.white,
                            width: 200,
                          ),
                          const CSpacer(40),
                          RichText(
                              text: const TextSpan(
                                  style: TextStyle(color: Colors.white),
                                  children: [
                                TextSpan(text: 'Email: '),
                                TextSpan(
                                    text: 'admin@costus.co.uk',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline))
                              ])),
                          const CSpacer(10),
                          const CText(
                            'Hanover Square, London W1S',
                            color: Colors.white,
                          ),
                          const CSpacer(20),
                          const CText(
                            "This email was sent to ashoffroad@gmail.com\nYou've received this email because you've subscribed to our newsletter.",
                            color: Colors.white,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
