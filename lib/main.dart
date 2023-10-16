import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:weslini/admin_web/admin.dart';
import 'package:weslini/connexion.dart';

import 'package:weslini/home.dart';
import 'package:weslini/passager/chat.dart';

import 'package:weslini/inscrPassager.dart';

void main() {
  runApp(MyApp());
}

//stateleess static data mchi button wlaa that text des images c tt
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, //pour enlever sharit a cote
        home: Connexion());
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
                  InscrPassager(), // Page d'accueil qui s'ouvre après l'animation
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
