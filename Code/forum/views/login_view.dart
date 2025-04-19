import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: const Color.fromRGBO(0, 127, 255, 1),
        elevation: 4,
      ),
      //
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      //
      body: Container(
        color: const Color.fromRGBO(0, 127, 255, 0.1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // WIDGET 1
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 4, 8, 24),
                child: Text(
                  "Welcome back",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 127, 255, 1),
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              // WIDGET 2
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Color.fromRGBO(0, 127, 255, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    hintText: "E-mail",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(0, 127, 255, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Color.fromRGBO(0, 127, 255, 0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 127, 255, 0.8),
                        style: BorderStyle.solid,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: const TextStyle(
                    color: Color.fromRGBO(0, 127, 255, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(0, 127, 255, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Color.fromRGBO(0, 127, 255, 0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 127, 255, 0.8),
                        style: BorderStyle.solid,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: TextButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      await AuthService.firebase().logIn(
                        email: email,
                        password: password,
                      );
                      final user = AuthService.firebase().currentUser;
                      if (user?.isEmailVerified ?? false) {
                        // user's email is verified
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          notesRoute,
                          (route) => false,
                        );
                      } else {
                        // user's email is NOT verified
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          verifyEmailRoute,
                          (route) => false,
                        );
                      }
                    } on UserNotFoundAuthException {
                      await showErrorDialog(
                        context,
                        'User not found',
                      );
                    } on WrongPasswordAuthException {
                      await showErrorDialog(
                        context,
                        'Wrong credentials',
                      );
                    } on GenericAuthException {
                      await showErrorDialog(
                        context,
                        'Authentication error',
                      );
                    }
                  },
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Color.fromRGBO(0, 191, 127, 0.15),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    minimumSize: WidgetStatePropertyAll(
                      Size(double.infinity, 52),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 150, 100, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 24, 8, 4),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerRoute,
                      (route) => false,
                    );
                  },
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Color.fromRGBO(0, 191, 127, 0.15),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    minimumSize: WidgetStatePropertyAll(
                      Size(double.infinity, 52),
                    ),
                  ),
                  child: const Text(
                    "New? Register instead.",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 150, 100, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
