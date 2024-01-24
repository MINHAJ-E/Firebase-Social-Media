import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebsesample/auth/logIn_reg.dart';
import 'package:firebsesample/view/home_screen.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if logged
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return const LoginReg();
          }
        },
      ),
    );
  }
}
