import 'package:flutter/material.dart';
import 'package:weslini/connexion.dart';
import 'package:weslini/inscrPassager.dart';
import 'package:weslini/passager/passager2.dart';
import 'package:weslini/profile.dart';

class PassagerHome extends StatefulWidget {
  const PassagerHome({Key? key});

  @override
  State<PassagerHome> createState() => _PassagerHomeState();
}

class _PassagerHomeState extends State<PassagerHome> {
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
                      'Passager ',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEC6294)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Ou allez vous ?',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFFEC6294)),
                    ),
                    Container(
                      child: TextField(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FormDestination()), // Utilisez la classe de la nouvelle page
                          );
                        },
                        decoration: InputDecoration(
                          labelText: 'Votre destination',
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFEC6294)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFEC6294)),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
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
              title: Text('Connexion'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Connexion()),
                );
              },
            ),
            ListTile(
              title: Text('InscrPassager'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InscrPassager()),
                );
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
