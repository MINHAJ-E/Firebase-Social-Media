import 'package:firebase_core/firebase_core.dart';
import 'package:firebsesample/controller/authentication_provider.dart';
import 'package:firebsesample/controller/bottom_provider.dart';
import 'package:firebsesample/controller/chat_provider.dart';
import 'package:firebsesample/services/auth.dart';
import 'package:firebsesample/services/firebase_options.dart';
import 'package:firebsesample/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AutheticationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PostProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
      ),
    );
  }
}
