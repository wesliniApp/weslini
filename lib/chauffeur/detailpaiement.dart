import 'package:flutter/material.dart';
import 'package:weslini/chauffeur/payerweslini.dart';

class DetailPaiement extends StatefulWidget {
  const DetailPaiement({super.key});

  @override
  State<DetailPaiement> createState() => _DetailPaiementState();
}

class _DetailPaiementState extends State<DetailPaiement> {
  Color textColor = Color(0xFF8C8C8C);
  Color textColorBlack = Color.fromARGB(255, 46, 46, 46);
  Color primaryColor = Color(0xFFEC6294);
  Color btngreyColor = Color(0xFF8C8C8C);
  @override
  Widget build(BuildContext context) {
    double seuilDeWidth = 251.0;
    double screenWidth = MediaQuery.of(context).size.width;
    bool doitMasquerLesConteneurs = screenWidth < seuilDeWidth;
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Visibility(
                          visible: !doitMasquerLesConteneurs,
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 3,
                            width: 30,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          'Janvier 2023',
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: screenWidth < 600 ? 20 : 24,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                        Visibility(
                          visible: !doitMasquerLesConteneurs,
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 3,
                            width: 30,
                            color: primaryColor,
                          ),
                        )
                      ],
                    )),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Text(
                        'la somme total',
                        style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: screenWidth < 600 ? 20 : 24,
                          fontWeight: FontWeight.bold,
                          color: textColorBlack,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: Text(
                        '18500 DZD',
                        style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: screenWidth < 600 ? 22 : 26,
                          fontWeight: FontWeight.normal,
                          color: textColorBlack,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'frais weslini',
                        style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: screenWidth < 600 ? 20 : 24,
                          fontWeight: FontWeight.bold,
                          color: textColorBlack,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: Text(
                        '5200 DZD',
                        style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: screenWidth < 600 ? 22 : 26,
                          fontWeight: FontWeight.normal,
                          color: textColorBlack,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'details de paiement',
                        style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: screenWidth < 600 ? 20 : 24,
                          fontWeight: FontWeight.bold,
                          color: textColorBlack,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Centrer les éléments horizontalement
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: Center(
                              child: Text(
                                'durée : 102h',
                                style: TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: screenWidth < 600 ? 20 : 24,
                                  fontWeight: FontWeight.normal,
                                  color: textColorBlack,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Center(
                              child: Text(
                                'courses : 50',
                                style: TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: screenWidth < 600 ? 20 : 24,
                                  fontWeight: FontWeight.normal,
                                  color: textColorBlack,
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
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PayerWeslini()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(
                    color: primaryColor,
                    width: 0.1,
                  ),
                ),
                elevation: 0.0,
              ),
              child: Text(
                'paiement bancaire',
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: screenWidth < 600
                      ? 16
                      : 20, // Taille de la police (responsive)
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
