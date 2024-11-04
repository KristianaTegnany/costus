import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/welcome/welcome_mobile_view.dart';
import 'package:costus/src/welcome/welcome_web_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepArgs {
  final bool? isGetstarted;
  StepArgs({this.isGetstarted});
}

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  static const routeName = '/';

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  void initState() {
    super.initState();
    context.read<ThemeCubit>().changeTheme(CategTheme.primary);
  }

  @override
  Widget build(BuildContext context) {
    return const StepLayout(
        isChild: true,
        child: SingleChildScrollView(
          child: kIsWeb
              ? WelcomeWebView()
              : WelcomeMobileView(),
        ));
  }
}
