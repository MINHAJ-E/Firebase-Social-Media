import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebsesample/services/firebase_auth.dart';
import 'package:firebsesample/view/home_screen.dart';
import 'package:firebsesample/widgets/my_button.dart';
import 'package:firebsesample/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUp> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  signUpUser() {
    FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
        email: usernameController.text,
        password: passwordController.text,
        context: context);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    usernameController.text = "";
    passwordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.grey[400],
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Welcome back  you\' ve been missed",
                style: TextStyle(color: Colors.grey[700], fontSize: 18),
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextfield(
                controller: usernameController,
                hintText: "Email",
                obsecureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextfield(
                controller: passwordController,
                hintText: "Password",
                obsecureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                onTap: () {
                  signUpUser();
                },
                name: 'Sign Up',
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }

  signInUser() {}
}
