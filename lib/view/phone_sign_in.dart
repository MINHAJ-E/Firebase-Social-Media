import 'package:firebsesample/controller/authentication_provider.dart';
import 'package:firebsesample/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneSignIn extends StatelessWidget {
  const PhoneSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
      ),
      body: Center(
        child: Consumer<AutheticationProvider>(
          builder: (context, value, child) => Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextfield(
                  controller: value.phoneController,
                  hintText: "phone number",
                  obsecureText: false),
              ElevatedButton(
                  onPressed: () {
                    value.phoneSignIn(context);
                  },
                  child: const Text("Sent OTP"))
            ],
          ),
        ),
      ),
    );
  }
}
