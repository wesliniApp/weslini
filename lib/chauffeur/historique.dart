import 'dart:html';

import 'package:flutter/material.dart';
import 'package:weslini/chauffeur/detailHistorique.dart';

class HistoriqueChauffeur extends StatefulWidget {
  const HistoriqueChauffeur({super.key});

  @override
  State<HistoriqueChauffeur> createState() => _HistoriqueChauffeurState();
}

class _HistoriqueChauffeurState extends State<HistoriqueChauffeur> {
  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294);
  Color btngreyColor = Color(0xFF8C8C8C);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Définir une hauteur seuil en dessous de laquelle le conteneur sera masqué
    double seuilDeHauteur = 600.0;

    // Vérifier si la hauteur de l'écran est inférieure au seuil
    bool doitMasquerLeConteneur = screenHeight < seuilDeHauteur;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Historique",
          style: TextStyle(
            fontFamily: 'inter',
            fontSize: screenWidth < 600 ? 16 : 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 20,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 17.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: screenWidth * 0.93,
                      height: screenHeight > 600
                          ? screenHeight * 0.25
                          : screenHeight * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset:
                                Offset(0, 2), // Changement de l'ombre verticale
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailHistorique()),
                            );
                          },
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    flex: 8,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text.rich(
                                        TextSpan(children: <TextSpan>[
                                          TextSpan(
                                            text: "16 novembre 2020 ",
                                            style: TextStyle(
                                              fontFamily: 'inter',
                                              fontSize:
                                                  screenWidth < 600 ? 14 : 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " 06:22",
                                            style: TextStyle(
                                              fontFamily: 'inter',
                                              fontSize:
                                                  screenWidth < 600 ? 14 : 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        "1167 DZD",
                                        style: TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: screenWidth < 600 ? 14 : 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 6.0,
                                    top: 15.0), // Marge à gauche de la ligne
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: screenWidth *
                                        0.9, // Largeur de la ligne verticale
                                    height:
                                        1.0, // Hauteur de la ligne verticale
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              Visibility(
                                visible: !doitMasquerLeConteneur,
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          width: 15.0, // Largeur du cercle
                                          height: 15.0, // Hauteur du cercle
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: primaryColor, width: 3),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "alger, algerie",
                                              style: TextStyle(
                                                fontFamily: 'inter',
                                                fontSize:
                                                    screenWidth < 600 ? 14 : 18,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "alger, algerie",
                                              style: TextStyle(
                                                fontFamily: 'inter',
                                                fontSize:
                                                    screenWidth < 600 ? 12 : 16,
                                                fontWeight: FontWeight.normal,
                                                color: textColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !doitMasquerLeConteneur,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 6.0), // Marge à gauche de la ligne
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width:
                                          2.0, // Largeur de la ligne verticale
                                      height: screenHeight *
                                          0.02, // Hauteur de la ligne verticale
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !doitMasquerLeConteneur,
                                child: Container(
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
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "alger, algerie",
                                              style: TextStyle(
                                                fontFamily: 'inter',
                                                fontSize:
                                                    screenWidth < 600 ? 14 : 18,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "alger, algerie",
                                              style: TextStyle(
                                                fontFamily: 'inter',
                                                fontSize:
                                                    screenWidth < 600 ? 12 : 16,
                                                fontWeight: FontWeight.normal,
                                                color: textColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
