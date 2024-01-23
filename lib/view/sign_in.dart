// ignore_for_file: use_build_context_synchronously, unused_local_variable, unnecessary_string_escapes

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebsesample/controller/authentication_provider.dart';
import 'package:firebsesample/widgets/my_button.dart';
import 'package:firebsesample/widgets/my_square_tile.dart';
import 'package:firebsesample/widgets/my_textfield.dart';
import 'package:firebsesample/view/phone_sign_in.dart';
import 'package:firebsesample/view/sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required void Function() onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void displaydlg(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AutheticationProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[400],
      body: Center(
        child: SingleChildScrollView(
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
                controller: provider.usernameController,
                hintText: "Username",
                obsecureText: false,
              ),
              const SizedBox(
                height: 5,
              ),
              MyTextfield(
                controller: provider.passwordController,
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
                    Text(
                      "Forgot password ?",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                name: "sign",
                onTap: () async {
                  String username = provider.usernameController.text.trim();
                  String password = provider.passwordController.text.trim();

                  if (username.isEmpty || password.isEmpty) {
                    // Show an alert if email or password is not typed properly
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Incomplete Information'),
                          content: const Text(
                              'Please enter both username and password.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    try {
                      UserCredential userCredential = await provider
                          .signInWithEmailandPassword(username, password);

                      // Do something with userCredential if needed

                      // User exists, clear controllers
                      provider.passwordController.clear();
                      provider.usernameController.clear();
                    } catch (e) {
                      // Show an alert that the user does not exist
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('User Not Found'),
                            content: const Text(
                                'The entered username or password is incorrect.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
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
                      ),
                    ),
                    Text('Or continue with'),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Provider.of<AutheticationProvider>(context,
                                listen: false)
                            .singupWithGoogle();
                      },
                      child: const SqureTile(imagePath: "asset/search.png")),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () => Provider.of<AutheticationProvider>(context,
                              listen: false)
                          .signInWithGithub(context),
                      child:
                          const SqureTile(imagePath: "asset/github-sign.png")),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PhoneSignIn()));
                      },
                      child:
                          const SqureTile(imagePath: "asset/cell-phone.png")),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUp(
                                onTap: () {},
                              )));
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
        ),
      ),
    );
  }
}
