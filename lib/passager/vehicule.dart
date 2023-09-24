import 'package:flutter/material.dart';
import 'package:weslini/passager/aide.dart';
import 'package:weslini/passager/coursier.dart';
import 'package:weslini/profile.dart';

class Vehicule extends StatefulWidget {
  const Vehicule({Key? key});

  @override
  State<Vehicule> createState() => _VehiculeState();
}

class _VehiculeState extends State<Vehicule> {
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
                      'Type de vehicule',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEC6294)),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.directions_car,
                              color: Color(0xFFEC6294),
                              size: 38.0,
                            ),
                            SizedBox(width: 70.0),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Aligner les éléments à gauche
                          children: [
                            InkWell(
                              onTap: () {
                                // Naviguez vers la nouvelle page ici
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Coursier(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Véhicule confort',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF979797),
                                    ),
                                  ),
                                  SizedBox(width: 60.0),
                                  Text(
                                    '670 DA',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF979797),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '3 véhicules',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF979797),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.directions_car,
                              color: Color(0xFFEC6294),
                              size: 38.0,
                            ),
                            SizedBox(width: 70.0),
                          ],
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Aligner les éléments à gauche
                          children: [
                            InkWell(
                              onTap: () {
                                // Naviguez vers la nouvelle page ici
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Coursier(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Véhicule simple',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF979797),
                                    ),
                                  ),
                                  SizedBox(width: 60.0),
                                  Text(
                                    '470 DA',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF979797),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '2 véhicules',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF979797),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  ],
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
              title: Text('Profil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
            ListTile(
              title: Text('Centre aide'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Aide()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
