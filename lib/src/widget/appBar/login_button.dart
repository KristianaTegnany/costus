import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  void goToLogin(context) {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 500;
    return kIsWeb && !isSmall
        ? Padding(
            padding: const EdgeInsets.only(right: 20),
            child: OutlinedButton(
                onPressed: () => goToLogin(context),
                child: const Text(
                  'Log In',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          )
        : BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return IconButton(
                iconSize: 25,
                icon: Icon(
                  Icons.person,
                  color: state.primary,
                ),
                onPressed: () => goToLogin(context),
              );
            },
          );
  }
}