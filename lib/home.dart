import 'package:flutter/material.dart';
import 'package:weslini/chauffeur/chauffeurHome.dart';
import 'package:weslini/passager.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChauffeurHome()), // Naviguez vers ChauffeurHome
                );
              },
              child: Text('Accès Chauffeur'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Passager()), // Naviguez vers PassagerHome
                );
              },
              child: Text('Accès Passager'),
            ),
          ],
        ),
      ),
    );
  }
}
