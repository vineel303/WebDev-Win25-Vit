import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Email verification",
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
              // WIDGET 1 //too large???
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 4, 8, 24),
                child: Text(
                  "Verify you email!",
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
                child: TextButton(
                  onPressed: () async {
                    await AuthService.firebase().sendEmailVerification();
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
                    "Send verification email",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 150, 100, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: TextButton(
                  onPressed: () async {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerRoute,
                      (route) => false,
                    );
                  }, //////
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
                    "Return",
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
