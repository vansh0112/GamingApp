import 'package:flutter/material.dart';
import 'package:flutterlogin_signup/pages/game1/main.dart';

class game1Page extends StatelessWidget{

  const game1Page(appUrl, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dino Game"),
      ),
      body: Center( // Center the button vertically and horizontally
        child: ElevatedButton(
          onPressed: () {
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