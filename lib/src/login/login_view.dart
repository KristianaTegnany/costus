import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/widget/input.dart';
import 'package:costus/src/widget/step_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return value!.isNotEmpty && !regex.hasMatch(value)
      ? 'Enter a valid email address'
      : null;
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const routeName = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool obscureText = true;
  bool isLoading = false;
  bool isFormValid = false;
  bool isLoginValid = false;

  void forgotPassword() {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: _usernameController.text)
        .then((_) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'An email has been sent to you to change your password'))));
  }

  void goToSignup() {
    Navigator.pushNamed(context, '/signup');
  }

  void goToHome() {
    Navigator.pushReplacementNamed(context, '/');
  }

  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  void login() {
    setLoading(true);

    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _usernameController.text,
              password: _passwordController.text)
          .then((_) {
        goToHome();
        setLoading(false);
      }).catchError((e) {
        setLoading(false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message ?? '')));
      });
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? '')));
    }
  }

  void validateForm(String value) {
    setState(() {
      isLoginValid = _usernameController.text.isNotEmpty;
      isFormValid = _passwordController.text.isNotEmpty &&
          validateEmail(_usernameController.text) == null;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 500;
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (_, themeState) {
        return Scaffold(
          backgroundColor: themeState.background,
          appBar: AppBar(
            backgroundColor: themeState.background,
            leading: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.home),
                  color: state.primary,
                  onPressed: goToHome,
                );
              },
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
                child: Center(
              child: Container(
                decoration: kIsWeb && !isSmall
                    ? BoxDecoration(
                        color: themeState.background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: border))
                    : null,
                width: isSmall ? double.infinity : 400,
                margin: const EdgeInsets.only(bottom: 40),
                padding: kIsWeb
                    ? const EdgeInsets.symmetric(vertical: 80, horizontal: 40)
                    : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const StepImage('login'),
                    const Text(
                      'Login to Your account',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Input(
                            controller: _usernameController,
                            errorText: validateEmail(_usernameController.text),
                            hintText: 'Email',
                            onChanged: validateForm,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Input(
                            controller: _passwordController,
                            hintText: 'Password',
                            secured: true,
                            onChanged: validateForm,
                            onEditingComplete: () => {
                              if (isFormValid) {login()}
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: isLoginValid ? forgotPassword : null,
                                child: Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(isLoginValid ? 1 : 0.5)),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FilledButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(themeState.primary),
                              shape: WidgetStatePropertyAll(
                                  BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              padding: const WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(vertical: 15)),
                            ),
                            onPressed: isFormValid ? login : null,
                            child: Padding(
                                padding: kIsWeb
                                    ? const EdgeInsets.symmetric(vertical: 10)
                                    : EdgeInsets.zero,
                                child: isLoading
                                    ? Container(
                                        height: 20,
                                        width: 20,
                                        padding: const EdgeInsets.all(2.0),
                                        child: const CircularProgressIndicator(
                                          color: background,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : const Text(
                                        'Sign In',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                          ),
                          kIsWeb
                              ? const SizedBox(
                                  height: 20,
                                )
                              : const SizedBox(),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account? ",
                              ),
                              TextButton(
                                  onPressed: goToSignup,
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(color: themeState.primary),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
          ),
        );
      },
    );
  }
}
