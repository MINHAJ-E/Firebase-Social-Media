import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebsesample/controller/authentication_provider.dart';
import 'package:firebsesample/services/phone_sign_in.dart';
import 'package:firebsesample/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneSignIn extends StatefulWidget {
  const PhoneSignIn({super.key});

  @override
  State<PhoneSignIn> createState() => _PhoneSignInState();
}

class _PhoneSignInState extends State<PhoneSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Consumer<AutheticationProvider>(
        builder: (context, value, child) => Column(
          children: [
            MyTextfield(
                controller: value.phoneController,
                hintText: "phone number",
                obsecureText: false),
            ElevatedButton(
                onPressed: () {
                  value.phoneSignIn(context);
                },
                child: Text("Sent OTP"))
          ],
        ),
      ),
    );
  }
}
