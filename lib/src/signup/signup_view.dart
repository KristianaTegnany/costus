import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:costus/src/login/login_view.dart';
import 'package:costus/src/cubit/theme_cubit.dart';
import 'package:costus/src/utils/theme/colors.dart';
import 'package:costus/src/widget/input.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:costus/src/widget/step_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String? validatePassword(String pass, String confirmPass) {
  return pass != confirmPass ? 'Passwords do not match' : null;
}

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  static const routeName = '/signup';

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  bool obscureText = true;
  bool isLoading = false;
  bool isFormValid = false;
  String? accountType;

  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  void goToHome() {
    Navigator.pushNamed(context, '/');
  }

  void goToSignin() {
    Navigator.pushNamed(context, '/login');
  }

  void updateAccount(String uid) async {
    final type = int.parse(accountType!.split(':')[0]);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({"email": _usernameController.text, "accountType": type});
  }

  void signUp() {
    setLoading(true);

    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _usernameController.text,
              password: _passwordController.text)
          .then((data) {
        updateAccount(data.user!.uid);
        goToHome();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Welcome to Costus')));
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
      isFormValid = validateEmail(_usernameController.text) == null &&
          _passwordController.text.isNotEmpty &&
          _passwordConfirmController.text == _passwordController.text;
    });
  }

  void toggleLock() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
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
            leading: IconButton(
              icon: const Icon(Icons.home),
              color: themeState.primary,
              onPressed: goToHome,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  decoration: kIsWeb && !isSmall
                      ? BoxDecoration(
                          color: background,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: border))
                      : null,
                  width: isSmall ? double.infinity : 400,
                  padding: kIsWeb
                      ? const EdgeInsets.symmetric(vertical: 80, horizontal: 40)
                      : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const StepImage('signup'),
                      const Text(
                        'Create account',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
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
                              errorText:
                                  validateEmail(_usernameController.text),
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
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Input(
                              controller: _passwordConfirmController,
                              errorText: validatePassword(
                                  _passwordController.text,
                                  _passwordConfirmController.text),
                              hintText: 'Confirm Password',
                              secured: true,
                              onChanged: validateForm,
                              onEditingComplete: () => {
                                if (isFormValid) {signUp()}
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyDropDown(
                                isForm: true,
                                data: const [
                                  {
                                    DataKey.id: '1',
                                    DataKey.data: 'mechanical',
                                    DataKey.value: 'Mechanical'
                                  },
                                  {
                                    DataKey.id: '2',
                                    DataKey.data: 'electrical',
                                    DataKey.value: 'Electrical'
                                  },
                                  {
                                    DataKey.id: '3',
                                    DataKey.data: 'building',
                                    DataKey.value: 'Building'
                                  }
                                ],
                                value: accountType,
                                label: "Account type",
                                onChange: (value) {
                                  setState(() {
                                    accountType = value;
                                  });
                                }),
                            const SizedBox(
                              height: kIsWeb ? 40 : 20,
                            ),
                            FilledButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(themeState.primary),
                                shape: WidgetStatePropertyAll(
                                    BeveledRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                padding: const WidgetStatePropertyAll(
                                    EdgeInsets.symmetric(vertical: 15)),
                              ),
                              onPressed: isFormValid ? signUp : null,
                              child: Padding(
                                  padding: kIsWeb
                                      ? const EdgeInsets.symmetric(vertical: 10)
                                      : EdgeInsets.zero,
                                  child: isLoading
                                      ? Container(
                                          height: 20,
                                          width: 20,
                                          padding: const EdgeInsets.all(2.0),
                                          child:
                                              const CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                            ),
                            kIsWeb
                                ? const SizedBox(
                                    height: 20,
                                  )
                                : const SizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account? "),
                                TextButton(
                                    onPressed: goToSignin,
                                    child: Text(
                                      "Sign In",
                                      style:
                                          TextStyle(color: themeState.primary),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
