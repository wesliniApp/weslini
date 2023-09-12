import 'package:flutter/material.dart';

class ChauffeurPassager extends StatefulWidget {
  const ChauffeurPassager({Key? key});

  @override
  State<ChauffeurPassager> createState() => _ChauffeurPassagerState();
}

class _ChauffeurPassagerState extends State<ChauffeurPassager> {
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
                      'Chauffeur',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEC6294)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Arrivera dans 5 min',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Audi,Ibiza noir',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          width: 150,
                        ),
                        Text(
                          '12332454321',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Center(
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.account_circle,
                                size: 40.0,
                                color: Color(0xFFEC6294),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Color(0xFFEC6294),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Color(0xFFEC6294),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Color(0xFFEC6294),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Color(0xFFEC6294),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Color(0xFFEC6294),
                                  ),
                                ],
                              ),
                              Text(
                                'Hamida nader',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 150,
                        ),
                        SizedBox(height: 20.0), // Espacement entre les colonnes
                        Column(
                          children: <Widget>[
                            Icon(
                              Icons.phone,
                              size: 49.0,
                              color: Color(0xFFEC6294),
                            ),
                            Text(
                              'Appler',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
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
    );
  }
}
