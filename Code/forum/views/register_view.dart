import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
          "Register",
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
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 4, 8, 24),
                child: Text(
                  "Hello, new friend.",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 127, 255, 1),
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              ////////
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
                    hintText: "Email",
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
              //////////////////
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
              //
              //
              //
              //
              //
              //widget
              //
              //
              //
              //
              //
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: TextButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      await AuthService.firebase().createUser(
                        email: email,
                        password: password,
                      );
                      AuthService.firebase().sendEmailVerification();
                      Navigator.of(context).pushNamed(verifyEmailRoute);
                    } on WeakPasswordAuthException {
                      await showErrorDialog(
                        context,
                        'Weak password',
                      );
                    } on EmailAlreadyInUseAuthException {
                      await showErrorDialog(
                        context,
                        'Email is already in use',
                      );
                    } on InvalidEmailAuthException {
                      await showErrorDialog(
                        context,
                        'This is an invalid email address',
                      );
                    } on GenericAuthException {
                      await showErrorDialog(
                        context,
                        'Failed to register',
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
                    "Register",
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
                      loginRoute,
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
                    "Registered? Login now.",
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
