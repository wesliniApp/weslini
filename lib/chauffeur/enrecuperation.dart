import 'package:flutter/material.dart';
import 'package:weslini/chauffeur/encourse.dart';

class Recuperation extends StatefulWidget {
  const Recuperation({super.key});

  @override
  State<Recuperation> createState() => _RecuperationState();
}

class _RecuperationState extends State<Recuperation> {
  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294);
  Color btngreyColor = Color(0xFF8C8C8C);

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
                    margin: EdgeInsets.only(top: 16.0, left: 20.0, right: 20.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 8,
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
                              Column(
                                children: <Widget>[
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
                                  SizedBox(
                                    height: 3.0,
                                  ),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) => Icon(
                                        Icons.star,
                                        color: primaryColor,
                                        size: screenWidth < 600 ? 12 : 14,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                height: screenWidth < 600 ? 30 : 35,
                                width: screenWidth < 600 ? 30 : 35,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor),
                                child: Icon(Icons.phone, color: Colors.white),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                height: screenWidth < 600 ? 30 : 35,
                                width: screenWidth < 600 ? 30 : 35,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor),
                                child: Icon(Icons.map, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.money,
                                  color: primaryColor,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "550 DZD",
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: screenWidth < 600 ? 14 : 16,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: screenWidth < 600 ? 200 : 300,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Course()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(16.0),
                              backgroundColor: btngreyColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'récupérer le passager',
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontSize: screenWidth < 600
                                    ? 14
                                    : 16, // Taille de la police (responsive)
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
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Option 1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Option 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
