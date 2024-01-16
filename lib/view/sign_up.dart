import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebsesample/services/phone_sign_in.dart';
import 'package:firebsesample/view/home_screen.dart';
import 'package:firebsesample/widgets/my_button.dart';
import 'package:firebsesample/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key, required void Function() onTap});

  @override
  State<SignUp> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUp> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConformController =
      TextEditingController();

  // signUpUser() {
  //   FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
  //       email: usernameController.text,
  //       password: passwordController.text,
  //       context: context);
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  //   usernameController.text = "";
  //   passwordController.text = "";
  // }
  void signUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    if (passwordController.text != passwordConformController.text) {
      Navigator.pop(context);
      displaydlg("Passwords do not match");
      return;
    }
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: usernameController.text, password: passwordController.text)
          .then((userCredential) {
        Navigator.pop(context); // Dismiss the loading dialog
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displaydlg(e.code);
    }
  }

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
              MyTextfield(
                controller: passwordConformController,
                hintText: "Conform",
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
                  // signUpUser();
                  signUp();
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
}
