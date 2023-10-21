import 'package:flutter/material.dart';
import 'package:flutterlogin_signup/pages/game4/home_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
 // const MyApp(appUrl, {super.key});
  Widget build(BuildContext context){
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          home:HomeScreen(),
    );
  }
}