import 'package:firebsesample/widgets/my_button.dart';
import 'package:firebsesample/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUp> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

              MyTextfield(
                controller: passwordController,
                hintText: "Confirm Password",
                obsecureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextfield(
                controller: passwordController,
                hintText: "Phone number",
                obsecureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                onTap: signInUser(),
                name: 'Sign Up',
              ),
              const SizedBox(
                height: 20,
              ),

              // const SizedBox(
              //   height: 20,
              // ),
              // MyButton(onTap: signInUser()),
              // const SizedBox(
              //   height: 20,
              // ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 25.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //           child: Divider(
              //         thickness: 0.5,
              //         color: Colors.black,
              //       )),
              //       Text('Or continue with'),
              //       Expanded(
              //           child: Divider(
              //         thickness: 0.5,
              //         color: Colors.black,
              //       ))
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 20),
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SqureTile(imagePath: "asset/search.png"),
              //     SizedBox(
              //       width: 20,
              //     ),
              //     SqureTile(imagePath: "asset/facebook.png"),
              //   ],
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       'Not a member?',
              //       style: TextStyle(
              //         color: Colors.grey[700],
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 5,
              //     ),
              //     const Text(
              //       'Register Now',
              //       style: TextStyle(
              //           color: Colors.blue, fontWeight: FontWeight.bold),
              //     )
              //   ],
              // )
            ],
          ),
        ));
  }

  signInUser() {}
}
