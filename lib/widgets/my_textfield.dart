import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;

  const MyTextfield({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obsecureText,
  }) : super(key: key);

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill in the field';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        //obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              // borderSide: BorderSide(color: Colors.white),
              ),
          fillColor: Colors.grey.shade300,
          filled: true,
          hintText: hintText,
        ),
        validator: _validateInput,
      ),
    );
  }
}
