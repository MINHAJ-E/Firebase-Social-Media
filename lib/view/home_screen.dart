import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebsesample/controller/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AutheticationProvider>(context, listen: false)
                    .signOut();
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("asset/padlock (1).png"),
            Image.asset("asset/padlock (1).png"),
            Image.asset("asset/padlock (1).png"),
          ],
        ),
      )),
    );
  }
}
