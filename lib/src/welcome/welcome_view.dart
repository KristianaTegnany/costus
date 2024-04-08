import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/utils/account/update_account_type.dart';
import 'package:costus/src/utils/subscription/subscription_dialog.dart';
import 'package:costus/src/widget/outlined_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  static const routeName = '/';

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
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
    return StepLayout(
        isChild: false,
        isWhite: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "The latest marker rates",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const Text(
                "All of the rates, all of the time.",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                  width: kIsWeb ? 400 : double.infinity,
                  child: BlocBuilder<ResultCubit, ResultState>(
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          MyOutlinedButton(
                              text: 'Mechanical',
                              disabled: isConnected && state.accountType != 1
                                  ? true
                                  : false,
                              onPress: () => goToStep(
                                  isConnected && state.accountType != 1,
                                  "1:1")),
                          MyOutlinedButton(
                              text: 'Electrical',
                              disabled: isConnected && state.accountType != 2
                                  ? true
                                  : false,
                              onPress: () => goToStep(
                                  isConnected && state.accountType != 2,
                                  "2:2")),
                          MyOutlinedButton(
                              text: 'Building',
                              disabled: isConnected && state.accountType != 3
                                  ? true
                                  : false,
                              onPress: () => goToStep(
                                  isConnected && state.accountType != 3,
                                  "3:3")),
                        ],
                      );
                    },
                  ))
            ],
          ),
        ));
  }
}
