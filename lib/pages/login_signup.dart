import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterlogin_signup/pages/login_page.dart';
import 'package:flutterlogin_signup/pages/signup_page.dart';

// ignore: camel_case_types
class Loginsignup extends StatefulWidget{
  const Loginsignup({Key? key}) : super(key: key);
  
  @override
  State<Loginsignup> createState() => _LoginsignupState();
}

// ignore: camel_case_types
class _LoginsignupState extends State<Loginsignup>{
  bool islogin = true;

  void togglePage(){
    setState(() {
      islogin = !islogin; 
    });
  }
  @override
  Widget build(BuildContext context) {
    if (islogin){
      return LoginPage(
        onPressed: togglePage,
        );
    }
    else{
        return SignupPage(
          onPressed: togglePage,
        );  
    }
    
  }
}