import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/steps/layout/widget/mobile_bottom.dart';
import 'package:costus/src/widget/appBar/my_appbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepLayout extends StatelessWidget {
  const StepLayout(
      {super.key,
      required this.child,
      this.isChild = true,
      this.isWebChild = false,
      this.title,
      this.onPress,
      this.isFirst = false,
      this.isStart = false,
      this.isResult = false,
      this.isAction = false,
      this.buttonDisabled = false});

  final Widget child;
  final bool isChild;
  final bool isWebChild;
  final String? title;
  final Function()? onPress;
  final bool isFirst;
  final bool isStart;
  final bool isResult;
  final bool isAction;
  final bool buttonDisabled;

  @override
  Widget build(BuildContext context) {
    return isWebChild == true
      ? child
      : BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Scaffold(
                backgroundColor: state.background,
                appBar: isChild
                    ? MyAppBar(
                        title: isAction ? '' : title,
                        isResult: !kIsWeb && isResult,
                      )
                    : null,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: child,
                    ),
                    onPress != null && !kIsWeb
                        ? MobileBottom(isFirst: isFirst, isResult: isResult, isStart: isStart, buttonDisabled: buttonDisabled, onPress: onPress,)
                        : const SizedBox(),
                  ],
                ));
          },
        );
  }
}
