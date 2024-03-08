import 'package:costus/src/steps/step_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const routeName = '/';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool obscureText = true;

  void goToHome() {
    bool isElectrical = _usernameController.text == 'costus' &&
        _passwordController.text == 'electrical';
    bool isMechanical = _usernameController.text == 'costus' &&
        _passwordController.text == 'mechanical';

    if (isElectrical || isMechanical) {
      Navigator.pushNamed(context, StepView.routeName);
    }
  }

  void toggleLock() {
    setState(() {
      obscureText = !obscureText;
    });
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
            child: Container(
              width: MediaQuery.of(context).size.width > 500
                  ? 500
                  : double.infinity,
              margin: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to',
                    style: TextStyle(fontSize: 28),
                  ),
                  Image.asset('assets/images/logo.png', width: 200),
                  const SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        hintText: 'Login',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.person),
                        )),
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
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  FilledButton(
                      onPressed: goToHome,
                      child: const Text(
                        'Sign In',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
