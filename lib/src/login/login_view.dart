import 'package:firebase_auth/firebase_auth.dart';
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
  bool isLoading = false;
  bool isFormValid = false;
  bool isLoginValid = false;

  void forgotPassword() {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: _usernameController.text);
  }

  void createAccount() {
    //FirebaseAuth.instance.cre
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
          .then((_) => setLoading(false));
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
          _usernameController.text.isNotEmpty;
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
                                  .onBackground
                                  .withOpacity(isLoginValid ? 1 : 0.5)),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FilledButton(
                      style: const ButtonStyle(
                          minimumSize: MaterialStatePropertyAll(Size(150, 40))),
                      onPressed: isFormValid ? login : null,
                      child: isLoading
                          ? Container(
                              height: 25,
                              width: 25,
                              padding: const EdgeInsets.all(2.0),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : const Text(
                              'Sign In',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                          onPressed: createAccount,
                          child: const Text("Sign Up"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
