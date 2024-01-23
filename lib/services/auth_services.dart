import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebsesample/constant/constants.dart';
import 'package:firebsesample/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServicesss {
  String collection = 'users';
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      // Sign in
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle specific error codes for invalid credentials
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw Exception('Invalid email or password');
      } else {
        throw Exception(e.code);
      }
    }
  }

  // Create a new user
  Future<UserCredential> signUpWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthMultiFactorException catch (e) {
      throw Exception(e.code);
    }
  }

  singinWithGoogle() async {
    try {
      final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gauth = await guser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gauth.accessToken, idToken: gauth.idToken);
      UserCredential user = await firebaseAuth.signInWithCredential(credential);
      User? googleuser = user.user;
      final UserAuthentication userdata = UserAuthentication(
          email: googleuser!.email,
          name: googleuser.displayName,
          uid: googleuser.uid);
      firestore.collection("users").doc(googleuser.uid).set(userdata.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  signInWithGithub(context) async {
    GithubAuthProvider githubAuthProvider = GithubAuthProvider();
    try {
      UserCredential user =
          await firebaseAuth.signInWithProvider(githubAuthProvider);
      User gituser = user.user!;
      final UserAuthentication userdata = UserAuthentication(
          email: gituser.email, name: gituser.displayName, uid: gituser.uid);
      firestore.collection("users").doc(gituser.uid).set(userdata.toJson());
      return user;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      throw Exception(e);
    }
  }

  //search services

  static Future<QuerySnapshot> searchUsers(String name) async {
    Future<QuerySnapshot> users = usersRef
        .where('name', isGreaterThanOrEqualTo: name)
        .where('name', isLessThan: '${name}z')
        .get();

    return users;
  }
}
