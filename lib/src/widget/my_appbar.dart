import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/utils/account/update_account_type.dart';
import 'package:costus/src/utils/subscription/subscription_dialog.dart';
import 'package:costus/src/welcome/welcome_view.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:costus/src/widget/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  void goToSignup(context) {
    Navigator.pushNamed(context, '/signup');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: RoundedButton(onPress: () => goToSignup(context), text: 'Sign Up'),
    );
  }
}

class Login extends StatelessWidget {
  const Login({super.key});

  void goToLogin(context) {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: OutlinedButton(
          onPressed: () => goToLogin(context),
          child: const Text(
            'Log In',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({super.key});

  void logout(context) {
    final isWelcome =
        ModalRoute.of(context)?.settings.name == WelcomeView.routeName;

    FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, isWelcome ? '/' : '/login');
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Padding(
            padding: const EdgeInsets.only(right: 40),
            child: OutlinedButton(
                onPressed: () => logout(context),
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          )
        : IconButton(
            iconSize: 25,
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          );
  }
}

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  final Size preferredSize;
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  void initState() {
    getAccountType().then((value) {
      setState(() {
        accountType = '$value:$value';
      });
    });
    super.initState();
  }

  String? accountType;

  Future<int?> getAccountType() async {
    final DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return user['accountType'] ?? 1;
  }

  void goToWelcome() {
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    final isWelcome =
        ModalRoute.of(context)?.settings.name == WelcomeView.routeName;
    final isConnected = FirebaseAuth.instance.currentUser != null;
    return AppBar(
      leading: isWelcome
          ? const SizedBox()
          : BlocBuilder<StepNavigationCubit, StepNavigationState>(
              builder: (context, state) {
              if (!kIsWeb && state is! StepNavigationInitial) {
                return IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () =>
                      context.read<StepNavigationCubit>().onPrevPressed(),
                );
              } else {
                return const SizedBox();
              }
            }),
      actions: [
        isWelcome
            ? Row(
                children: isConnected
                    ? [const Logout()]
                    : [
                        const Login(),
                        const SignUp(),
                      ])
            : BlocBuilder<StepNavigationCubit, StepNavigationState>(
                builder: (context, state) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      kIsWeb && isConnected
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: BlocBuilder<ResultCubit, ResultState>(
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
                                      onChange: (value) {
                                        if (value != null) {
                                          onChangeAccountType(context, value,
                                              () {
                                            int type =
                                                int.parse(value.split(':')[0]);
                                            updateAccountType(type, () {
                                              setState(() {
                                                accountType = value;
                                              });
                                            });
                                            context
                                                .read<ResultCubit>()
                                                .onAccountTypeChanged(type);
                                          });
                                        }
                                      });
                                },
                              ),
                            )
                          : const SizedBox(),
                      isConnected ? const Logout() : const Login(),
                      isConnected ? const SizedBox() : const SignUp()
                    ],
                  );
                },
              )
      ],
      iconTheme: const IconThemeData()
          .copyWith(color: Theme.of(context).colorScheme.primary),
      title: InkWell(
        onTap: kIsWeb ? goToWelcome : null,
        child: Image.asset(
          'assets/images/logo.png',
          width: 200,
        ),
      ),
      centerTitle: !kIsWeb,
    );
  }
}
