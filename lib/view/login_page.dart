import 'package:flutter/material.dart';
import 'package:video_conference_app/services/login_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset("assets/images/onboarding.jpg"),
              const SizedBox(
                height: 48,
              ),
              ElevatedButton(
                  onPressed: () async{
                    await LoginServices.signInWithGoogle();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 22,
                      horizontal: 48,
                    ),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        width: 20,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      const Text("Continue with Google")
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
