import 'package:flutter/material.dart';

class Trajet extends StatefulWidget {
  const Trajet({Key? key});

  @override
  State<Trajet> createState() => _TrajetState();
}

class _TrajetState extends State<Trajet> {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 16),
                    Text(
                      'Votre trajet',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEC6294)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.account_circle,
                              size: 40.0,
                              color: Color(0xFFEC6294),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Hamida nader',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Audi Ibiza noir',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
// Espacement entre les colonnes
                      ],
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 15.0, // Largeur du cercle
                                        height: 15.0, // Hauteur du cercle
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: primaryColor, width: 3),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "alger, algerie",
                                          style: TextStyle(
                                            fontFamily: 'inter',
                                            fontSize:
                                                screenWidth < 600 ? 14 : 18,
                                            fontWeight: FontWeight.normal,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 6.0), // Marge à gauche de la ligne
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width:
                                          2.0, // Largeur de la ligne verticale
                                      height:
                                          20.0, // Hauteur de la ligne verticale
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 15.0,
                                        height: 15.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: primaryColor, width: 3),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "alger, algerie",
                                          style: TextStyle(
                                            fontFamily: 'inter',
                                            fontSize:
                                                screenWidth < 600 ? 14 : 18,
                                            fontWeight: FontWeight.normal,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width < 600
                                      ? 10
                                      : 20, // Espacement entre les boutons
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.money_outlined,
                              size: 30.0,
                              color: Color(0xFFEC6294),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '550 DA',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            SizedBox(width: 80),
                            Text(
                              'Partager votre trajet',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFFEC6294)),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.share,
                              size: 18.0,
                              color: Color(0xFFEC6294),
                            ),
                          ],
                        ),
// Espacement entre les colonnes
                      ],
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
