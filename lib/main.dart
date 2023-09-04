import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mon Application Flutter'), // Ajoutez le texte ici
        ),
        body: Center(
          child: Text(
            'Bienvenue dans mon application Flutter!', // Ajoutez votre texte ici
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
