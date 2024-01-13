import 'package:flutter/material.dart';
import 'package:weslini/chauffeur/detailHistorique.dart';
import 'package:weslini/backend/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoriqueChauffeur extends StatefulWidget {
  const HistoriqueChauffeur({super.key});

  @override
  State<HistoriqueChauffeur> createState() => _HistoriqueChauffeurState();
}

class _HistoriqueChauffeurState extends State<HistoriqueChauffeur> {
  List<Map<String, dynamic>> courseState = [];

  Future<void> fetchUserData() async {
    try {
      final response =
          await http.get(Uri.parse('${Utils.baseUrl}/user/historique'));

      if (response.statusCode == 200) {
        print('object1');
        // If the server returns an OK response, parse the JSON
        Map<String, dynamic>? responseData = jsonDecode(response.body);

        // Check if responseData is not null before proceeding
        if (responseData != null) {
          print('object2, $responseData');

          // Check if 'success' key is present and has a true value

          final List<Map<String, dynamic>>? courseData =
              (responseData['data'] as List<dynamic>?)
                  ?.cast<Map<String, dynamic>>();
          print('courseData $courseData');
          if (courseData != null) {
            setState(() {
              courseState = courseData;
              print('courseState $courseState');
            });
            print('courseStattye $courseState');
          } else {
            print('Invalid format for course data.');
          }
        } else {
          // Handle the case where responseData is null
          print('Empty responseData');
          throw Exception('Empty response data');
        }
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        print('Failed to load user data: ${response.statusCode}');
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      // Handle any exceptions that might occur during the HTTP request
      print('Error: $e');
    }
  }

  void processCourseData(Map<String, dynamic> data) {
    final String prixCourse = data['prix'].toString();
    // Add your logic to use prixCourse as needed, for example, print it
    print('prixCourse: $prixCourse');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
  }

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
        itemCount: courseState.length,
        itemBuilder: (context, index) {
          final data = courseState[index];
          final String idChauffeur = data['id_chauffeur'].toString();
          final String idPassager = data['id_passager'].toString();

          final String marqueVehicule =
              data['Chauffeur[\'marque_vehicule\']'].toString();
          final String couleurVehicule =
              data['Chauffeur[\'couleur_vehicule\']'].toString();
          final String plaqueVehicule =
              data['Chauffeur[\'plaque_immatriculation\']'].toString();
          final String typeOffre =
              data['Chauffeur[\'type_offre\']'].toString();

          final String nomPassager =
              data['UtilisateurPassager[\'nom\']'].toString();
          final String prenomPassager =
              data['UtilisateurPassager[\'prenom\']'].toString();

          final String duree = data['duree'].toString();
          final String distance = data['distance'].toString();

          final String prixCourse = data['prix'].toString();
          final String date = data['date'].toString();
          final String time = data['time'].toString();
          final String wilayaDepart = data['wilayaDepart'].toString();
          final String wilayaDistination = data['wilayaDistination'].toString();
          final String localisationDepart =
              data['localisationDepart'].toString();
          final String localisationDistination =
              data['localisationDistination'].toString();

          return Padding(
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
                      offset: Offset(0, 2),
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
                          builder: (context) => DetailHistorique(
                            idChauffeur: idPassager,
                            idPassager: idPassager,
                            prixCourse: prixCourse,
                            typeOffre: typeOffre,
                            marqueVehicule: marqueVehicule,
                            couleurVehicule: couleurVehicule,
                            plaqueVehicule: plaqueVehicule,
                            nomPassager: nomPassager,
                            prenomPassager: prenomPassager,
                            date: date,
                            time: time,
                            duree: duree,
                            distance: distance,
                            wilayaDepart: wilayaDepart,
                            wilayaDistination: wilayaDistination,
                            localisationDepart: localisationDepart,
                            localisationDistination: localisationDistination,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 8,
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text.rich(
                                    TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "$date ",
                                          style: TextStyle(
                                            fontFamily: 'inter',
                                            fontSize:
                                                screenWidth < 600 ? 14 : 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              "   ", // Add a space between date and time
                                        ),
                                        TextSpan(
                                          text: "$time",
                                          style: TextStyle(
                                            fontFamily: 'inter',
                                            fontSize:
                                                screenWidth < 600 ? 14 : 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "$prixCourse",
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
                          margin: EdgeInsets.only(left: 6.0, top: 15.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: screenWidth * 0.9,
                              height: 1.0,
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
                                    width: 15.0,
                                    height: 15.0,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "$wilayaDepart",
                                        style: TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: screenWidth < 600 ? 14 : 18,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "$localisationDepart",
                                        style: TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: screenWidth < 600 ? 12 : 16,
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
                            margin: EdgeInsets.only(left: 6.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 2.0,
                                height: screenHeight * 0.02,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "$wilayaDistination",
                                        style: TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: screenWidth < 600 ? 14 : 18,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "$localisationDistination",
                                        style: TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: screenWidth < 600 ? 12 : 16,
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
          );
        },
      ),
    );
  }
}


/*import 'package:flutter/material.dart';
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
*/