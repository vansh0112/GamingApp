import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'game1/game1.dart';
import './game2/game2.dart';
import './game3/game3.dart';
import './game4/game4.dart';

class GameApp {
  final String name;
  final String iconUrl;
  final String appUrl;

  GameApp(this.name, this.iconUrl, this.appUrl);
}


class GameTile extends StatelessWidget {
  final GameApp gameApp;

  GameTile(this.gameApp);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          
          if (gameApp.name == 'Dino Game') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => game1Page(gameApp.appUrl)),
            );
          } 
          else if (gameApp.name == 'Chess Game') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => game2Page(gameApp.appUrl)),
            );
          }
          else if (gameApp.name == 'Tetris') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => game3Page(gameApp.appUrl)),
            );
          }
          else if (gameApp.name == 'Tic Tac Toe') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => game4Page(gameApp.appUrl)),
            );
          }
        },
        child: Column(
          children: [
            Image.asset(
              gameApp.iconUrl,
              width: 180,
              height: 180,
            ),
            const SizedBox(height: 8),
            Text(gameApp.name,
            style: const TextStyle(fontSize: 18),),
          ],
        ),
      ),
    );
  }
}



class HomePage extends StatelessWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser;
  final List<GameApp> gameApps = [
    
    GameApp('Dino Game', 'assests/download.png', 'game1.dart'),
    GameApp('Chess Game', 'assests/images.jpg', 'game2.dart'),
    GameApp('Tetris', 'assests/Tetris.webp', 'game3.dart'),
    GameApp('Tic Tac Toe', 'assests/tictaetoe.jpg', 'game4.dart'),
    
    // Add more games as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.login),
          ),
        ],
        
      ),
      body: Stack(
        children: [
          Positioned(
            top: 200, 
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 2; i++)
                      if (i < gameApps.length) GameTile(gameApps[i])
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 2; i < 4; i++)
                      if (i < gameApps.length) GameTile(gameApps[i])
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
