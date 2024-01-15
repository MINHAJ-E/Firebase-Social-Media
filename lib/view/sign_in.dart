import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebsesample/services/firebase_auth.dart';
import 'package:firebsesample/view/sign_up.dart';
import 'package:firebsesample/widgets/my_button.dart';
import 'package:firebsesample/widgets/my_square_tile.dart';
import 'package:firebsesample/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  signUpUser() {
    FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
        email: usernameController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   backgroundColor: Colors.amber,
        // ),

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
                hintText: "Username",
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Forgot password ?"),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                onTap: () {
                  signUpUser();
                },
                name: 'Sign In',
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    )),
                    Text('Or continue with'),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ))
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SqureTile(imagePath: "asset/search.png"),
                  SizedBox(
                    width: 20,
                  ),
                  SqureTile(imagePath: "asset/facebook.png"),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: const Text(
                      'Register Now',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
