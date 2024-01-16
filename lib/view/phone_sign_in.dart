import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebsesample/services/firebase_auth.dart';
import 'package:firebsesample/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class PhoneSignIn extends StatefulWidget {
  const PhoneSignIn({super.key});

  @override
  State<PhoneSignIn> createState() => _PhoneSignInState();
}

class _PhoneSignInState extends State<PhoneSignIn> {
  void phoneSignIn() {
    FirebaseAuthMethods(FirebaseAuth.instance)
        .phoneSignIn(context, phoneController.text);
  }

  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          MyTextfield(
              controller: phoneController,
              hintText: "phone number",
              obsecureText: false),
          ElevatedButton(onPressed: phoneSignIn, child: Text("Sent OTP"))
        ],
      ),
    );
  }
}
