import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebsesample/services/auth_services.dart';
import 'package:firebsesample/services/phone_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AutheticationProvider extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController Confpasswordcontroller = TextEditingController();

  Future<UserCredential>? user;
  AuthServicesss authservices = AuthServicesss();
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    return authservices.signInWithEmailandPassword(email, password);
  }

//create a new user
  Future<UserCredential> signUpWithEmailandPassword(
      String email, password) async {
    return authservices.signUpWithEmailandPassword(email, password);
  }

  phoneSignIn(BuildContext context) {
    FirebaseAuthMethods(FirebaseAuth.instance)
        .phoneSignIn(context, phoneController.text);
  }

  Future<void> signOut() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  singupWithGoogle() {
    return authservices.singinWithGoogle();
  }

  signInWithGithub(context) {
    return authservices.signInWithGithub(context);
  }
}
