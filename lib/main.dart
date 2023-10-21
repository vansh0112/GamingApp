import 'package:firebase_core/firebase_core.dart';
import 'package:flutterlogin_signup/pages/auth_page.dart';
import 'package:flutterlogin_signup/pages/login_page.dart';
import 'package:flutterlogin_signup/pages/signup_page.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const AuthPage(),
    );
  }
}

