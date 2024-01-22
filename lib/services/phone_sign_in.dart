import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebsesample/widgets/show_otp_dialog.dart';
import 'package:firebsesample/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);
  //phone sign in

  Future<void> phoneSignIn(
    BuildContext context,
    String phoneNumber,
  ) async {
    TextEditingController codeController = TextEditingController();
    // For android and ios
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          showSnackbar(context, e.message!);
          print(e.message);
        },
        codeSent: ((String verificationId, int? resentToken) async {
          showOTPDialog(
              codeController: codeController,
              context: context,
              onpressed: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: codeController.text.trim());
                await _auth.signInWithCredential(credential);
                Navigator.of(context).pop();
              });
        }),
        codeAutoRetrievalTimeout: (String verificationId) {
          //auto resolution time out....
        });
  }
}
