// ignore_for_file: file_names
import 'package:firebsesample/view/sign_in.dart';
import 'package:firebsesample/view/sign_up.dart';
import 'package:flutter/material.dart';

class LoginReg extends StatefulWidget {
  const LoginReg({Key? key}) : super(key: key);

  @override
  State<LoginReg> createState() => _LoginRegState();
}

class _LoginRegState extends State<LoginReg> {
  bool showLoginPage = true;

  void toggle() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: toggle);
    } else {
      return SignUp(onTap: toggle);
    }
  }
}
