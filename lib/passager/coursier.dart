import 'package:flutter/material.dart';

class Coursier extends StatefulWidget {
  const Coursier({Key? key});

  @override
  State<Coursier> createState() => _CoursierState();
}

class _CoursierState extends State<Coursier> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294); // Couleur grise

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white, size: 30.0),
        leading: GestureDetector(
          onTap: _openDrawer,
          child: Container(
            margin: EdgeInsets.only(left: 10, top: 10),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor,
            ),
            child: Center(
              child: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: screenWidth,
            height: double.infinity,
            color: Colors.grey,
            child: Align(
              alignment:
                  Alignment.topCenter, // Alignez l'image en haut de l'écran
              child: Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(top: 200.0), // Espacement vers le haut
                    width: 200.0, // Largeur souhaitée de l'image
                    height: 200.0, // Hauteur souhaitée de l'image
                    child: Image.asset(
                      'assets/car.png', // Assurez-vous de spécifier le bon chemin
                      fit: BoxFit
                          .contain, // Ajustez l'image à la taille du conteneur
                    ),
                  ),
                  // Ajoutez d'autres widgets ici si nécessaire
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: screenWidth,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50),
                    Text(
                      'Recherche du coursier ...',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEC6294)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
