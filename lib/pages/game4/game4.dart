import 'package:flutter/material.dart';
import 'package:flutterlogin_signup/pages/game4/main.dart';

class game4Page extends StatelessWidget {
  final String appUrl;

  game4Page(this.appUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () 
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ),
            );
          }, 
          child: Text(
            "Launch Game",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
      ),
      
    ),
    );
  }
}
