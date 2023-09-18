import 'package:flutter/material.dart';
import 'package:weslini/chauffeur/detailpaiement.dart';

class GainChauffeur extends StatefulWidget {
  const GainChauffeur({super.key});

  @override
  State<GainChauffeur> createState() => _GainChauffeurState();
}

class _GainChauffeurState extends State<GainChauffeur> {
  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294);
  Color btngreyColor = Color(0xFF8C8C8C);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 20,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.1,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPaiement()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 16.0, left: 25.0, right: 25.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          "fevrier",
                                          style: TextStyle(
                                            fontFamily: 'inter',
                                            fontSize:
                                                screenWidth < 600 ? 16 : 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3.0,
                                        ),
                                        Text(
                                          "2020",
                                          style: TextStyle(
                                            fontFamily: 'inter',
                                            fontSize:
                                                screenWidth < 600 ? 12 : 16,
                                            color: Colors.black,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "8540 DZD",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text("Payé",
                                        style: TextStyle(color: Colors.green)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
