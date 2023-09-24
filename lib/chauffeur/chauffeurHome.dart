import 'package:flutter/material.dart';
import 'package:weslini/chauffeur/enrecuperation.dart';
import 'package:weslini/chauffeur/gain.dart';
import 'package:weslini/chauffeur/historique.dart';
import 'package:weslini/chauffeur/inscription.dart';

class ChauffeurHome extends StatefulWidget {
  const ChauffeurHome({Key? key});

  @override
  State<ChauffeurHome> createState() => _ChauffeurHomeState();
}

class _ChauffeurHomeState extends State<ChauffeurHome> {
  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10, top: 10),
            width: screenWidth * 0.2, // Ajustez la largeur ici
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              shape: BoxShape.rectangle,
              color: Color(0xFF383838).withOpacity(0.75),
            ),
            child: Center(
              child: Text(
                "00:12",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
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
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "20KM",
                                style: TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: screenWidth < 600
                                      ? 16
                                      : 20, // Taille de la police (responsive)
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text.rich(
                                TextSpan(children: <TextSpan>[
                                  TextSpan(
                                    text: "Durée ",
                                    style: TextStyle(
                                      fontFamily: 'inter',
                                      fontSize: screenWidth < 600 ? 12 : 14,
                                      fontWeight: FontWeight.normal,
                                      color: textColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "8min",
                                    style: TextStyle(
                                      fontFamily: 'inter',
                                      fontSize: screenWidth < 600 ? 10 : 12,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "20KM",
                                style: TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: screenWidth < 600 ? 16 : 20,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text.rich(
                                TextSpan(children: <TextSpan>[
                                  TextSpan(
                                    text: "Prix net ",
                                    style: TextStyle(
                                      fontFamily: 'inter',
                                      fontSize: screenWidth < 600 ? 12 : 14,
                                      fontWeight: FontWeight.normal,
                                      color: textColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "470 DZD",
                                    style: TextStyle(
                                      fontFamily: 'inter',
                                      fontSize: screenWidth < 600 ? 10 : 12,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 30,
                                height: 30,
                                child: Center(
                                  child: IconTheme(
                                    data: IconThemeData(
                                      color: primaryColor,
                                      size: screenWidth < 600 ? 30 : 35,
                                    ),
                                    child: Icon(Icons.account_circle),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "amel ben",
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: screenWidth < 600 ? 16 : 20,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
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
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
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
                                          fontSize: screenWidth < 600 ? 14 : 18,
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
                                    width: 2.0, // Largeur de la ligne verticale
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
                                          fontSize: screenWidth < 600 ? 14 : 18,
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
                                width: screenWidth < 600 ? 100 : 150,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChauffeurHome()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(16.0),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(
                                        color: primaryColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    elevation: 0.0,
                                  ),
                                  child: Text(
                                    'Refuser',
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth < 600
                                    ? 10
                                    : 20, // Espacement entre les boutons
                              ),
                              SizedBox(
                                width: screenWidth < 600 ? 150 : 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Recuperation()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(16.0),
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text('Accepter'),
                                ),
                              ),
                            ],
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Historique'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoriqueChauffeur()),
                );
              },
            ),
            ListTile(
              title: Text('Revenus'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GainChauffeur()),
                );
              },
            ),
            ListTile(
              title: Text('inscription'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyForm()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
