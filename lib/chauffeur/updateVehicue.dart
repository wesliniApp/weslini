import 'dart:convert';

import 'package:weslini/home.dart';
import 'package:weslini/backend/rest_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'dart:async';
import 'package:weslini/backend/utils.dart';

class updateVehicule extends StatefulWidget {
  const updateVehicule({super.key});

  @override
  State<updateVehicule> createState() => _updateVehiculeState();
}

class _updateVehiculeState extends State<updateVehicule> {
  Future<Map<String, dynamic>> fetchUserData() async {
    final response =
        await http.get(Uri.parse('${Utils.baseUrl}/user/vehiculeShow'));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load user data');
    }
  }

  String? marqueShow;
  String? anneeShow;
  String? couleurShow;
  String? motorisationShow;
  String? plaqueShow;

  @override
  void initState() {
    super.initState();
    // Call the function to fetch user data when the widget is created
    fetchUserData().then((userData) {
      setState(() {
        // Update the state with the retrieved user data
        marqueShow = userData['marque_vehicule'];
        anneeShow = userData['annee_vehicule'].toString();
        couleurShow = userData['couleur_vehicule'];
        motorisationShow = userData['motorisation_du_vehicule'];
        plaqueShow = userData['plaque_immatriculation'].toString();
      });
    }).catchError((error) {
      // Handle errors, e.g., show an error message to the user
      print('Error fetching user data: $error');
    });
  }

  Future<void> updateProfile() async {
    final Uri url = Uri.parse('${Utils.baseUrl}/user/vehiculeUpdate');
    final Map<String, dynamic> requestBody = {
      'marque': marqueController.text,
      'annee': anneeController.text,
      'couleur': couleurController.text,
      'motorisation': motorisationController.text,
      'plaque': plaqueController.text,
    };

    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Gérez la réponse réussie, par exemple, affichez une confirmation à l'utilisateur.
      showSnackBar(context, 'Profil mis à jour avec succès');
    } else {
      // Gérez l'échec de la mise à jour, affichez une erreur à l'utilisateur.
      showSnackBar(context, 'Erreur lors de la mise à jour du profil');
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294);
  Color btngreyColor = Color(0xFF8C8C8C);
  Color textColorBlack = Color.fromARGB(255, 46, 46, 46);

  TextEditingController marqueController = TextEditingController();
  TextEditingController anneeController = TextEditingController();
  TextEditingController couleurController = TextEditingController();
  TextEditingController motorisationController = TextEditingController();
  TextEditingController plaqueController = TextEditingController();
  void updateMarque(String newValue) {
    setState(() {
      marqueController.text = newValue;
    });
  }

  void updateAnnee(String newValue) {
    setState(() {
      anneeController.text = newValue;
    });
  }

  void updateCouleur(String newValue) {
    setState(() {
      couleurController.text = newValue;
    });
  }

  void updateMotorisation(String newValue) {
    setState(() {
      motorisationController.text = newValue;
    });
  }

  Future<void> testPlaque(String plaque) async {
    final res = await sendRequestPlaque(plaque.trim());
    if (res['success']) {
      setState(() {
        messagePlaque = true;
      });
    } else {
      setState(() {
        messagePlaque = false;
      });
    }
  }

  bool messagePlaque = true;

  Future sendRequesty(String numeroTelephone) async {
    final Uri url = Uri.parse('${Utils.baseUrl}/user/testNum');
    final Map<String, dynamic> requestBody = {
      'numero_telephone': numeroTelephone,
    };
    print(requestBody);

    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json", // Set the content-type to JSON
      },
      body: jsonEncode(requestBody), // Encode the body as JSON
    );

    var decodeData = jsonDecode(response.body);
    return decodeData;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String? selectedFileName;

    final List<String> marque = ['gonow', 'bmw', 'cherry'];
    String? selectedMarque;

    final List<String> annee = ['2020', '2010', '2003'];
    String? selectedAnnee;

    final List<String> couleur = ['grise', 'rouge', 'blanche'];
    String? selectedCouleur;

    final List<String> motorisation = ['none', 'dsel', 'essence'];
    String? selectedMotorisation;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            "Modifier le sinformations de vehicule",
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
        body: ListView(children: <Widget>[
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Text(
              "Information de vehicule",
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: DropdownButtonFormField<String>(
                hint: Text('$marqueShow'),
                value: selectedMarque, // Use the selectedSexe variable
                onChanged: (newValue) {
                  updateMarque(newValue!); // Call the updateSexe function
                },
                items: marque.map((marque) {
                  return DropdownMenuItem<String>(
                    value: marque,
                    child: Text(marque),
                  );
                }).toList(),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFEC6294),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: DropdownButtonFormField<String>(
                hint: Text('$anneeShow'),
                value: selectedAnnee, // Use the selectedSexe variable
                onChanged: (newValue) {
                  updateAnnee(newValue!); // Call the updateSexe function
                },
                items: annee.map((annee) {
                  return DropdownMenuItem<String>(
                    value: annee,
                    child: Text(annee),
                  );
                }).toList(),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFEC6294),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: DropdownButtonFormField<String>(
                hint: Text('$couleurShow'),
                value: selectedCouleur, // Use the selectedSexe variable
                onChanged: (newValue) {
                  updateCouleur(newValue!); // Call the updateSexe function
                },
                items: couleur.map((couleur) {
                  return DropdownMenuItem<String>(
                    value: couleur,
                    child: Text(couleur),
                  );
                }).toList(),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFEC6294),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: DropdownButtonFormField<String>(
                hint: Text('$motorisationShow'),
                value: selectedMotorisation, // Use the selectedSexe variable
                onChanged: (newValue) {
                  updateMotorisation(newValue!); // Call the updateSexe function
                },
                items: motorisation.map((motorisation) {
                  return DropdownMenuItem<String>(
                    value: motorisation,
                    child: Text(motorisation),
                  );
                }).toList(),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFEC6294),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: plaqueController,
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: primaryColor,
                      ),
                      onChanged: (plaque) {
                        testPlaque(plaque);
                      },
                      decoration: InputDecoration(
                          hintText: '$plaqueShow',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink),
                          ) // C'est le placeholder
                          ),
                    ),
                    if (!messagePlaque)
                      Text(
                        "Vous avez deja un compte chauffeur avec ce numero",
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                )),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    updateProfile();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEC6294),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text("Confirmer"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
        ]));
  }
}
