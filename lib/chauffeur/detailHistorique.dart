import 'package:flutter/material.dart';

class DetailHistorique extends StatefulWidget {
  const DetailHistorique({super.key});

  @override
  State<DetailHistorique> createState() => _DetailHistoriqueState();
}

class _DetailHistoriqueState extends State<DetailHistorique> {
  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294);
  Color btngreyColor = Color(0xFF8C8C8C);
  Color textColorBlack = Color.fromARGB(255, 46, 46, 46);

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
          "Revenus",
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
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 17.0),
            child: Wrap(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // Changement de l'ombre verticale
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "classique",
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: screenWidth < 600 ? 14 : 18,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: <Widget>[
                            Icon(Icons.car_crash, size: 24.0),
                            SizedBox(
                                width: 10.0), // Espace horizontal de 10 pixels
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "ZOTYE T200 - Cris Argent",
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: screenWidth < 600 ? 14 : 18,
                                    fontWeight: FontWeight.bold,
                                    color: textColorBlack,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "18057-112-35",
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: screenWidth < 600 ? 14 : 18,
                                    fontWeight: FontWeight.normal,
                                    color: textColorBlack,
                                  ),
                                ),
                              ],
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
                              height: 1.0, // Hauteur de la ligne verticale
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.account_circle, size: 24.0),
                            SizedBox(
                                width: 5.0), // Espace horizontal de 10 pixels
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "nadjet boum",
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: screenWidth < 600 ? 14 : 18,
                                    fontWeight: FontWeight.bold,
                                    color: textColorBlack,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => Icon(
                                      Icons.star,
                                      color: primaryColor,
                                      size: screenWidth < 600 ? 16 : 20,
                                    ),
                                  ),
                                ),
                              ],
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
                              height: 1.0, // Hauteur de la ligne verticale
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
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
                              Expanded(
                                  child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'durée : 102h',
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: screenWidth < 600 ? 14 : 20,
                                    fontWeight: FontWeight.bold,
                                    color: textColorBlack,
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 6.0), // Marge à gauche de la ligne
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 2.0, // Largeur de la ligne verticale
                              height: screenHeight *
                                  0.02, // Hauteur de la ligne verticale
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
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
                              Expanded(
                                  child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'distance : 15km',
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: screenWidth < 600 ? 14 : 20,
                                    fontWeight: FontWeight.bold,
                                    color: textColorBlack,
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // Changement de l'ombre verticale
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Prix",
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: screenWidth < 600 ? 14 : 18,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "1167 DZD",
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: screenWidth < 600 ? 14 : 18,
                            fontWeight: FontWeight.normal,
                            color: textColorBlack,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.money,
                              color: primaryColor,
                              size: 20.0,
                            ),
                            Text(
                              "Paiement en espèce",
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontSize: screenWidth < 600 ? 14 : 18,
                                fontWeight: FontWeight.normal,
                                color: textColorBlack,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // Changement de l'ombre verticale
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Note et commentaire",
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: screenWidth < 600 ? 14 : 18,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              color: primaryColor,
                              size: screenWidth < 600 ? 16 : 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Sans commentaire",
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: screenWidth < 600 ? 14 : 18,
                            fontWeight: FontWeight.normal,
                            color: textColorBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // Changement de l'ombre verticale
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Identifiant de la course",
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: screenWidth < 600 ? 14 : 18,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "AAW2R7ZEQ9",
                                style: TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: screenWidth < 600 ? 14 : 18,
                                  fontWeight: FontWeight.normal,
                                  color: textColorBlack,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Wrap(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment
                                        .centerRight, // Cela aligne le texte à droite
                                    child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25.0))),
                                      child: Text(
                                        "Copier",
                                        style: TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: screenWidth < 600 ? 14 : 18,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // Changement de l'ombre verticale
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Besion d'aide",
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: screenWidth < 600 ? 14 : 18,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "Si vous avez un problème avec cette course, contactes otre service client pour plus d'aide",
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: screenWidth < 600 ? 14 : 18,
                            fontWeight: FontWeight.normal,
                            color: textColorBlack,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.question_mark,
                              color: primaryColor,
                              size: 20.0,
                            ),
                            Text(
                              "Centre d'aide",
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontSize: screenWidth < 600 ? 14 : 18,
                                fontWeight: FontWeight.normal,
                                color: textColorBlack,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
