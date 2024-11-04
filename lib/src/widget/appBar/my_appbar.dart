import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/utils/account/update_account_type.dart';
import 'package:costus/src/utils/subscription/subscription_dialog.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/welcome/welcome_view.dart';
import 'package:costus/src/widget/appBar/account_type_action.dart';
import 'package:costus/src/widget/appBar/leading.dart';
import 'package:costus/src/widget/appBar/login_button.dart';
import 'package:costus/src/widget/appBar/logout_button.dart';
import 'package:costus/src/widget/appBar/signup_button.dart';
import 'package:costus/src/widget/appBar/title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, this.title, this.isResult})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  final String? title;
  final bool? isResult;

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
    if (FirebaseAuth.instance.currentUser != null) {
      final DocumentSnapshot user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      return user['accountType'] ?? 1;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 500;
    final isWelcome =
        ModalRoute.of(context)?.settings.name == WelcomeView.routeName;
    final isConnected = FirebaseAuth.instance.currentUser != null;
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (_, themeState) {
        return AppBar(
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: !kIsWeb && !isWelcome
              ? Leading(isResult: widget.isResult, themeState: themeState) : const SizedBox(),
          actions: kIsWeb
              ? []
              : [
                  isWelcome
                      ? Row(
                          children: isConnected
                              ? [const Logout()]
                              : [
                                  const Login(),
                                  isSmall ? const SizedBox() : const SignUp(),
                                ])
                      : AccountTypeAction(
                        accountType: accountType,
                        isConnected: isConnected,
                        isSmall: isSmall,
                        onChange: (value) {
                          if (value != null) {
                            onChangeAccountType(
                                context, value, () {
                              int type = int.parse(
                                  value.split(':')[0]);
                              updateAccountType(type,
                                  () {
                                setState(() {
                                  accountType = value;
                                });
                              });
                              context
                                  .read<ResultCubit>()
                                  .onAccountTypeChanged(
                                      type);
                            });
                          }
                        })
                ],
          iconTheme: const IconThemeData().copyWith(color: primary),
          centerTitle: true,
          title: TitleBar(isWelcome: isWelcome, isResult: widget.isResult, title: widget.title, themeState: themeState),
          backgroundColor: kIsWeb || widget.isResult == true
              ? themeState.primary
              : themeState.background ?? background,
        );
      },
    );
  }
}
