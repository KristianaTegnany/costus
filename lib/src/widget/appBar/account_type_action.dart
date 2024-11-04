import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/widget/appBar/login_button.dart';
import 'package:costus/src/widget/appBar/logout_button.dart';
import 'package:costus/src/widget/appBar/signup_button.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountTypeAction extends StatelessWidget {
  const AccountTypeAction({super.key, this.accountType, required this.onChange, required this.isConnected, required this.isSmall});

  final bool isConnected;
  final bool isSmall;
  final String? accountType;
  final Function(String?) onChange;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepNavigationCubit, StepNavigationState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            kIsWeb && isConnected
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40),
                    child: BlocBuilder<ResultCubit,
                        ResultState>(
                      builder: (context, _) {
                        return MyDropDown(
                            isExpanded: false,
                            isForm: true,
                            data: const [
                              {
                                DataKey.id: '1',
                                DataKey.data: '1',
                                DataKey.value: 'Mechanical'
                              },
                              {
                                DataKey.id: '2',
                                DataKey.data: '2',
                                DataKey.value: 'Electrical'
                              },
                              {
                                DataKey.id: '3',
                                DataKey.data: '3',
                                DataKey.value: 'Building'
                              }
                            ],
                            value: accountType,
                            label: "Account type",
                            onChange: onChange,);
                      },
                    ),
                  )
                : const SizedBox(),
            isConnected ? const Logout() : const Login(),
            isConnected || isSmall
                ? const SizedBox()
                : const SignUp()
          ],
        );
      },
    );
  }
}