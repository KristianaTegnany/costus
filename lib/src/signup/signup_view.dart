import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:costus/src/login/login_view.dart';
import 'package:costus/src/widget/my_dropdown.dart';
import 'package:costus/src/widget/subscribe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  String? validatePassword(String confirmPassword) {
    if (confirmPassword != _passwordController.text) {
      return "Password don't match";
    }
    return null;
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                decoration: kIsWeb
                    ? BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 2,
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.1)))
                    : null,
                width: MediaQuery.of(context).size.width > 500
                    ? 400
                    : double.infinity,
                margin: const EdgeInsets.all(40),
                padding: kIsWeb
                    ? const EdgeInsets.symmetric(vertical: 40, horizontal: 40)
                    : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Create account',
                      style: TextStyle(fontSize: 24),
                    ),
                    Image.asset('assets/images/logo.png', width: 200),
                    const SizedBox(
                      height: 40,
                    ),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          errorText: validateEmail(_usernameController.text),
                          hintText: 'Email',
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.person),
                          )),
                      onChanged: validateForm,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.lock),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                            icon: Icon(obscureText ? Icons.key : Icons.key_off),
                            onPressed: toggleLock,
                          ),
                        ),
                      ),
                      onChanged: validateForm,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _passwordConfirmController,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        errorText:
                            validatePassword(_passwordConfirmController.text),
                        hintText: 'Confirm Password',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.lock),
                        ),
                      ),
                      onChanged: validateForm,
                      onEditingComplete: () {
                        if (isFormValid) {
                          signUp();
                        }
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
                      style: const ButtonStyle(
                          minimumSize: MaterialStatePropertyAll(Size(150, 40))),
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
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Text(
                                  'Sign Up',
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                            onPressed: goToSignin, child: const Text("Sign In"))
                      ],
                    ),
                    const Subscribe()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
