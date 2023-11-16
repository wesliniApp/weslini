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

class updateCarte extends StatefulWidget {
  const updateCarte({super.key});

  @override
  State<updateCarte> createState() => _updateCarteState();
}

class _updateCarteState extends State<updateCarte> {
  Future<Map<String, dynamic>> fetchUserData() async {
    final response =
        await http.get(Uri.parse('${Utils.baseUrl}/user/carteShow'));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load user data');
    }
  }

  String? permisrectoShow;
  String? permisversoeShow;
  String? identiteShow;
  String? griseShow;
  String? assuranceShow;

  @override
  void initState() {
    super.initState();
    // Call the function to fetch user data when the widget is created
    fetchUserData().then((userData) {
      setState(() {
        // Update the state with the retrieved user data
        permisrectoShow = userData['marque_vehicule'];
        permisversoeShow = userData['annee_vehicule'].toString();
        identiteShow = userData['couleur_vehicule'];
        griseShow = userData['motorisation_du_vehicule'];
        assuranceShow = userData['plaque_immatriculation'].toString();
      });
    }).catchError((error) {
      // Handle errors, e.g., show an error message to the user
      print('Error fetching user data: $error');
    });
  }

  Future<void> updateProfile() async {
    final Uri url = Uri.parse('${Utils.baseUrl}/user/carteUpdate');
    final Map<String, dynamic> requestBody = {
      'permisrecto': permisrectoController.text,
      'permisverso': permisversoController.text,
      'identite': identiteController.text,
      'grise': griseController.text,
      'assurance': assuranceController.text,
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

  TextEditingController permisrectoController = TextEditingController();
  TextEditingController permisversoController = TextEditingController();
  TextEditingController identiteController = TextEditingController();
  TextEditingController griseController = TextEditingController();
  TextEditingController assuranceController = TextEditingController();

  void updatePermisverso(file) {
    setState(() {
      permisversoController.text = file;
    });
  }

  updatePermisrecto(file) {
    setState(() {
      permisrectoController.text = file;
    });
  }

  void updateIdentite(file) {
    setState(() {
      identiteController.text = file;
    });
  }

  void updateGrise(file) {
    setState(() {
      griseController.text = file;
    });
  }

  void updateAssurance(file) {
    setState(() {
      assuranceController.text = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String? selectedOptionSexe;
    String? selectedOptionVille;
    String? selectedFileName;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Modifier le sinformations des cartes",
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
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Text(
              "Inssérez vos carte",
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
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Pour aligner le label à gauche
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: PopupMenuButton<String>(
                          icon: Icon(Icons.help_outline), // Icône de question
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'help',
                                child: ListTile(
                                  title: Text('Comment importer un fichier'),
                                  onTap: () {
                                    // Afficher le popup avec l'image et les instructions ici
                                    Navigator.pop(
                                        context); // Fermer le menu contextuel
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Instructions d\'importation'),
                                          content: Column(
                                            children: [
                                              Image.asset('assets/permis1.png'),
                                              Image.asset(
                                                  'assets/permis2.jpg'), // Remplacez 'assets/import_instructions.png' par le chemin de votre image
                                              Text(
                                                  'Suivez ces instructions pour importer un fichier.'),
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Fermer la boîte de dialogue
                                              },
                                              child: Text('Fermer'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ];
                          },
                          onSelected: (String value) {
                            // Gérez d'autres actions ici si nécessaire
                          },
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Photo du permis de conduire*',
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10), // Espace entre le label et le Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Column(
                          children: <Widget>[
                            Text(
                              permisrectoController.text.isEmpty
                                  ? 'Aucun fichier sélectionné'
                                  : permisrectoController.text,
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              permisversoController.text.isEmpty
                                  ? 'Aucun fichier sélectionné'
                                  : permisversoController.text,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Flexible(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              PlatformFile file = result.files.first;

                              // Mettez à jour le contrôleur avec le nom du fichier sélectionné
                              updatePermisrecto(file.name);

                              // Vous pouvez également stocker le chemin du fichier si nécessaire
                              String? filePath = file.path;
                            }
                          },
                          child: Text("Parcourir photo recto de permis"),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              PlatformFile file = result.files.first;

                              // Mettez à jour le contrôleur avec le nom du fichier sélectionné
                              updatePermisverso(file.name);

                              // Vous pouvez également stocker le chemin du fichier si nécessaire
                              String? filePath = file.path;
                            }
                          },
                          child: Text("Parcourir photo verso de permis"),
                        ),
                      ),
                    ],
                  ),
                ],
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
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Pour aligner le label à gauche
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: PopupMenuButton<String>(
                          icon: Icon(Icons.help_outline), // Icône de question
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'help',
                                child: ListTile(
                                  title: Text('Comment importer un fichier'),
                                  onTap: () {
                                    // Afficher le popup avec l'image et les instructions ici
                                    Navigator.pop(
                                        context); // Fermer le menu contextuel
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Instructions d\'importation'),
                                          content: Column(
                                            children: [
                                              Image.asset(
                                                  'assets/identite.png'), // Remplacez 'assets/import_instructions.png' par le chemin de votre image
                                              Text(
                                                  'Suivez ces instructions pour importer un fichier.'),
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Fermer la boîte de dialogue
                                              },
                                              child: Text('Fermer'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ];
                          },
                          onSelected: (String value) {
                            // Gérez d'autres actions ici si nécessaire
                          },
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Photo d identité*',
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10), // Espace entre le label et le Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Text(
                          identiteController.text.isEmpty
                              ? 'Aucun fichier sélectionné'
                              : identiteController.text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                primaryColor, // Couleur de fond du bouton
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              PlatformFile file = result.files.first;

                              // Mettez à jour le contrôleur avec le nom du fichier sélectionné
                              updateIdentite(file.name);

                              // Vous pouvez également stocker le chemin du fichier si nécessaire
                              String? filePath = file.path;

                              // Maintenant, le texte du contrôleur contient le nom du fichier sélectionné
                            }
                          },
                          child: Text("Parcourir"),
                        ),
                      ),
                    ],
                  ),
                ],
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
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Pour aligner le label à gauche
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: PopupMenuButton<String>(
                          icon: Icon(Icons.help_outline), // Icône de question
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'help',
                                child: ListTile(
                                  title: Text('Comment importer un fichier'),
                                  onTap: () {
                                    // Afficher le popup avec l'image et les instructions ici
                                    Navigator.pop(
                                        context); // Fermer le menu contextuel
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Instructions d\'importation'),
                                          content: Column(
                                            children: [
                                              Image.asset(
                                                  'assets/grise.jpg'), // Remplacez 'assets/import_instructions.png' par le chemin de votre image
                                              Text(
                                                  'Suivez ces instructions pour importer un fichier.'),
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Fermer la boîte de dialogue
                                              },
                                              child: Text('Fermer'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ];
                          },
                          onSelected: (String value) {
                            // Gérez d'autres actions ici si nécessaire
                          },
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Carte Grise*',
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10), // Espace entre le label et le Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Text(
                          griseController.text.isEmpty
                              ? 'Aucun fichier sélectionné'
                              : griseController.text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                primaryColor, // Couleur de fond du bouton
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              PlatformFile file = result.files.first;

                              // Mettez à jour le contrôleur avec le nom du fichier sélectionné
                              updateGrise(file.name);

                              String? filePath = file.path;
                            }
                          },
                          child: Text("Parcourir"),
                        ),
                      ),
                    ],
                  ),
                ],
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
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Pour aligner le label à gauche
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      PopupMenuButton<String>(
                        icon: Icon(Icons.help_outline), // Icône de question
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'help',
                              child: ListTile(
                                title: Text('Comment importer un fichier'),
                                onTap: () {
                                  // Afficher le popup avec l'image et les instructions ici
                                  Navigator.pop(
                                      context); // Fermer le menu contextuel
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            Text('Instructions d\'importation'),
                                        content: Column(
                                          children: [
                                            Image.asset(
                                                'assets/assurance.jpg'), // Remplacez 'assets/import_instructions.png' par le chemin de votre image
                                            Text(
                                                'Suivez ces instructions pour importer un fichier.'),
                                          ],
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  context); // Fermer la boîte de dialogue
                                            },
                                            child: Text('Fermer'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ];
                        },
                        onSelected: (String value) {
                          // Gérez d'autres actions ici si nécessaire
                        },
                      ),
                      Flexible(
                        child: Text(
                          'Carte Assurance*',
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 10), // Espace entre le label et le Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Text(
                          assuranceController.text.isEmpty
                              ? 'Aucun fichier sélectionné'
                              : assuranceController.text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                primaryColor, // Couleur de fond du bouton
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              PlatformFile file = result.files.first;

                              // Mettez à jour le contrôleur avec le nom du fichier sélectionné
                              updateAssurance(file.name);

                              String? filePath = file.path;
                            }
                          },
                          child: Text("Parcourir"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
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
            child: Text(
              'Confirmer',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          )
        ],
      ),
    );
  }
}
