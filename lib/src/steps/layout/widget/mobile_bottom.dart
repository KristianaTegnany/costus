
import 'package:costus/src/steps/home/cubit/option_cubit.dart';
import 'package:costus/src/steps/step_view.dart';
import 'package:costus/src/widget/circle_button.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileBottom extends StatelessWidget {
  const MobileBottom({super.key, required this.isFirst, required this.isResult, required this.isStart, required this.buttonDisabled, this.onPress});

  final bool isFirst;
  final bool isResult;
  final bool isStart;
  final bool buttonDisabled;
  final Function()? onPress;
  
  @override
  Widget build(BuildContext context) {
    final isConnected = FirebaseAuth.instance.currentUser != null;
    final isDisabled = buttonDisabled && !isConnected;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: isFirst
          ? Align(
              alignment: Alignment.centerRight,
              child: CircleButton(
                disabled: isDisabled,
                onPress:
                    isDisabled ? null : onPress,
              ),
            )
          : Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                children: [
                  isConnected || isResult
                      ? const SizedBox()
                      : BlocBuilder<OptionCubit,
                          OptionState>(
                          builder: (_, state) {
                            return state
                                    is OptionChosen
                                ? Padding(
                                    padding:
                                        const EdgeInsets
                                            .only(
                                            bottom:
                                                40),
                                    child: Text(
                                      textAlign:
                                          TextAlign
                                              .center,
                                      titles[state
                                          .chosenOption]!,
                                      style:
                                          const TextStyle(
                                              fontSize:
                                                  18),
                                    ),
                                  )
                                : const SizedBox();
                          },
                        ),
                  isStart
                      ? const SizedBox()
                      : isResult
                          ? Padding(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                      horizontal: 20),
                              child: RectButton(
                                  disabled:
                                      isDisabled,
                                  isPrimary: true,
                                  text: isResult
                                      ? 'To print and share'
                                      : 'Start',
                                  onPress:
                                      isDisabled
                                          ? null
                                          : onPress),
                            )
                          : Align(
                              alignment: Alignment
                                  .centerRight,
                              child: CircleButton(
                                disabled:
                                    isDisabled,
                                onPress:
                                    isDisabled
                                        ? null
                                        : onPress,
                              ),
                            )
                ],
              ),
            ),
    );
  }
}
