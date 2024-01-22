import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebsesample/controller/authentication_provider.dart';
import 'package:firebsesample/services/phone_sign_in.dart';
import 'package:firebsesample/view/home_screen.dart';
import 'package:firebsesample/widgets/my_button.dart';
import 'package:firebsesample/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key, required void Function() onTap}) : super(key: key);

  @override
  State<SignUp> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final value = Provider.of<AutheticationProvider>(context, listen: false);
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
              "Welcome back you've been missed",
              style: TextStyle(color: Colors.grey[700], fontSize: 18),
            ),
            const SizedBox(
              height: 30,
            ),
            MyTextfield(
              controller: value.usernameController,
              hintText: "Email",
              obsecureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextfield(
              controller: value.passwordController,
              hintText: "Password",
              obsecureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            MyTextfield(
              controller: value.Confpasswordcontroller,
              hintText: "Conform",
              obsecureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              name: "Register",
              onTap: () async {
                // Check if any field is empty
                if (value.usernameController.text.isEmpty ||
                    value.passwordController.text.isEmpty ||
                    value.Confpasswordcontroller.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: const Text("All fields must be filled out."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }

                // Check if the password and confirmation password match
                if (value.passwordController.text ==
                    value.Confpasswordcontroller.text) {
                  try {
                    // If they match, call the signUpWithEmailandPassword method
                    await value.signUpWithEmailandPassword(
                      value.usernameController.text,
                      value.passwordController.text,
                    );
                    value.usernameController.clear();
                    value.passwordController.clear();
                    value.Confpasswordcontroller.clear();

                    // Navigate to the home screen after successful account creation
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  } catch (e) {
                    // Handle any errors that occur during account creation
                    print("Error creating account: $e");
                  }
                } else {
                  // If passwords don't match, show an error message
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: const Text("Passwords do not match."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
