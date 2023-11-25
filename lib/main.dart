import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:weslini/admin_web/admin.dart';
import 'package:weslini/chauffeur/inscription.dart';
import 'package:weslini/chauffeur/map.dart';
import 'package:weslini/chauffeur/position.dart';
import 'package:weslini/connexion/connexion.dart';
import 'package:weslini/map.dart';

import 'package:weslini/passager/chat.dart';

import 'package:weslini/passager/inscrPassager.dart';

void main() {
  runApp(MyApp());
}

//stateleess static data mchi button wlaa that text des images c tt
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, //pour enlever sharit a cote
        home: position());
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color primaryColor = Color(0xFFEC6294);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      color: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AnimatedSplashScreen(
              splash: Image.asset(
                'assets/logo.png',
                width: MediaQuery.of(context).size.width * 0.5,
                fit: BoxFit.cover,
              ),
              backgroundColor: Color(0xFFEC6294),
              nextScreen:
                  Connexion(), // Page d'accueil qui s'ouvre après l'animation
              splashTransition: SplashTransition.fadeTransition,
              duration:
                  2000, // Durée de l'animation en millisecondes (20 secondes dans votre cas)
            ),
          ),
        ],
      ),
    ));
  }
}
