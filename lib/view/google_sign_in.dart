import 'package:firebsesample/services/google_sign_in.dart';
import 'package:firebsesample/widgets/my_button.dart';
import 'package:firebsesample/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class GoogleSignIn extends StatefulWidget {
  const GoogleSignIn({super.key});

  @override
  State<GoogleSignIn> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          MyTextfield(
              obsecureText: false,
              hintText: "email",
              controller: emailController),
          SizedBox(
            height: 20,
          ),
          MyTextfield(
              obsecureText: false,
              hintText: "email",
              controller: passwordController),
          SizedBox(
            height: 20,
          ),
          MyButton(
            name: "Sign In",
            onTap: () {},
          )
        ],
      ),
    );
  }
}
