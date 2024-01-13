import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weslini/admin_web/admin.dart';
import 'package:weslini/chauffeur/enrecuperation.dart';
import 'package:weslini/chauffeur/gain.dart';
import 'package:weslini/essaye/chauffeur.dart';

import 'package:weslini/chauffeur/historique.dart';
import 'package:http/http.dart' as http;

import 'package:weslini/chauffeur/inscription.dart';
import 'package:weslini/chauffeur/map.dart';
import 'package:weslini/chauffeur/profilechauffeur.dart';
import 'package:weslini/chauffeur/updateCarte.dart';
import 'package:weslini/chauffeur/updatePerso.dart';
import 'package:weslini/chauffeur/updateVehicue.dart';
import 'package:weslini/connexion/connexion.dart';
import 'package:weslini/backend/utils.dart';
import 'package:weslini/home.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChauffeurHome extends StatefulWidget {
  @override
  _ChauffeurHomeState createState() => _ChauffeurHomeState();
}

class _ChauffeurHomeState extends State<ChauffeurHome> {
  bool isOnline = false;
  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294);
  late GoogleMapController mapController;

  Future<void> logout() async {
    final String url = '${Utils.baseUrl}/user/logout';

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        // Vous pouvez ajouter d'autres en-têtes au besoin
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['success']) {
        // Déconnexion réussie, naviguez vers l'écran de connexion par exemple
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Connexion()),
        );
      } else {
        print(responseData['message']);
      }
    } else {
      print('Échec de la déconnexion');
    }
  }

  Future<void> updateEtatConnexion() async {
    print('hhhhhhhhh');
    try {
      final response = await http
          .get(Uri.parse('${Utils.baseUrl}/user/update_etat_connexion'));
      print('ssssssssss');

      if (response.statusCode == 200) {
        print('ccccccc');

        final dynamic responseData = jsonDecode(response.body);

        if (responseData != null && responseData['success']) {
        } else {
          print('Failed to fetch positions1');
        }
      } else {
        print('Failed to fetch positions2');
      }
    } catch (error) {
      print('Error fetching positions: $error');
    } finally {}
  }

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
      body: Align(
        child: !isOnline
            ? Container(
                color: Colors.black.withOpacity(0.5),
                child: Stack(children: <Widget>[
                  Container(
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isOnline = true;
                            // Don't use Navigator.of(context).pop() here
                            updateEtatConnexion();
                          });
                        },
                        child: Text('soit enligne'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              primaryColor, // Couleur d'arrière-plan du bouton
                        ),
                      ),
                    ),
                  ),
                ]),
              )
            : Container(
                color: Colors.grey.withOpacity(0.5),
                child: Stack(
                  children: <Widget>[
                    GoogleMap(
                      onMapCreated: (controller) {
                        setState(() {
                          mapController = controller;
                        });
                      },
                      initialCameraPosition: CameraPosition(
                        target:
                            LatLng(37.7749, -122.4194), // Coordonnées initiales
                        zoom: 12.0, // Niveau de zoom initial
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 40.0,
                          height: 40.0,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isOnline = false;
                                // Don't use Navigator.of(context).pop() here
                                updateEtatConnexion();
                              });
                            },
                            child: Icon(
                              Icons.power_settings_new, // Icon "off"
                              size: 30.0,
                              color: Colors.white,
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(
                                  0), // Pas de rembourrage interne
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10.0), // Bord arrondi
                              ),
                              backgroundColor: Colors
                                  .black, // Couleur d'arrière-plan du bouton
                            ),
                          ),
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
                                                fontSize:
                                                    screenWidth < 600 ? 12 : 14,
                                                fontWeight: FontWeight.normal,
                                                color: textColor,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "8min",
                                              style: TextStyle(
                                                fontFamily: 'inter',
                                                fontSize:
                                                    screenWidth < 600 ? 10 : 12,
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
                                            fontSize:
                                                screenWidth < 600 ? 16 : 20,
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
                                                fontSize:
                                                    screenWidth < 600 ? 12 : 14,
                                                fontWeight: FontWeight.normal,
                                                color: textColor,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "470 DZD",
                                              style: TextStyle(
                                                fontFamily: 'inter',
                                                fontSize:
                                                    screenWidth < 600 ? 10 : 12,
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
                                                size:
                                                    screenWidth < 600 ? 30 : 35,
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
                                              fontSize:
                                                  screenWidth < 600 ? 16 : 20,
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
                                                width:
                                                    15.0, // Largeur du cercle
                                                height:
                                                    15.0, // Hauteur du cercle
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: primaryColor,
                                                      width: 3),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.0),
                                                child: Text(
                                                  "alger, algerie",
                                                  style: TextStyle(
                                                    fontFamily: 'inter',
                                                    fontSize: screenWidth < 600
                                                        ? 14
                                                        : 18,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: textColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left:
                                                  6.0), // Marge à gauche de la ligne
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
                                                      color: primaryColor,
                                                      width: 3),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.0),
                                                child: Text(
                                                  "alger, algerie",
                                                  style: TextStyle(
                                                    fontFamily: 'inter',
                                                    fontSize: screenWidth < 600
                                                        ? 14
                                                        : 18,
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          width: screenWidth < 600 ? 100 : 150,
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(16.0),
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                side: BorderSide(
                                                  color: primaryColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                              elevation: 0.0,
                                            ),
                                            child: Text(
                                              'Refuser',
                                              style: TextStyle(
                                                  color: primaryColor),
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
                                                    builder: (context) =>
                                                        Recuperation()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(16.0),
                                              backgroundColor: primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
              ),
      ),
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
            width: screenWidth * 0.2,
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Chauffeur'),
              onTap: () {},
            ),
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
            ListTile(
              title: Text('connexion'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Connexion()),
                );
              },
            ),
            ListTile(
              title: Text('profil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileChauffeur()),
                );
              },
            ),
            ListTile(
              title: Text('UpdatePerso'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdatePerso()),
                );
              },
            ),
            ListTile(
              title: Text('updateVehicule'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => updateVehicule()),
                );
              },
            ),
            ListTile(
              title: Text('updateCarte'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => updateCarte()),
                );
              },
            ),
            ListTile(
              title: Text('Update Carte'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MapScreenn()), // Use MapScreen, not Map
                );
              },
            ),
            ListTile(
              title: Text('Update Carte'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MapScreenn()), // Use MapScreen, not Map
                );
              },
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  // Appeler la fonction de déconnexion ici
                  logout();
                },
                child: Text('Se déconnecter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, // Set background color here
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
