import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<String> genre = ['Femme', 'Homme'];
  String selectedGender = 'Femme';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  String email = '';
  String nom = '';
  String prenom = 'Abcd';
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
    // Call the function to fetch user data when the widget is created
    fetchUserData().then((userData) {
      setState(() {
        // Update the state with the retrieved user data
        email = userData['email'];
        nom = userData['nom'];
        prenom = userData['prenom'];
        phoneNumber = userData['numero_telephone'];
      });
    }).catchError((error) {
      // Handle errors, e.g., show an error message to the user
      print('Error fetching user data: $error');
    });
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.14:3000/user/PassagerShow'));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load user data');
    }
  }

  Future<void> updateProfile() async {
    final Uri url = Uri.parse('http://192.168.1.14:3000/user/profile');

    final Map<String, dynamic> requestBody = {
      'nom': nomController.text,
      'prenom': prenomController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'numero_telephone': numeroController.text,
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
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Profil mis à jour'),
              content: Text('Votre profil a été mis à jour avec succès.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    } else {
      // Gérez l'échec de la mise à jour, affichez une erreur à l'utilisateur.
      print('Erreur lors de la mise à jour du profil');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEC6294),
        title: Text(
          "Modifier le profil",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            SizedBox(
              height: 60,
            ),
            CircleAvatar(
              backgroundColor: Color(0xFF8C8C8C), // Couleur de fond du cercle
              radius: 40, // Rayon du cercle
              child: Text(
                prenom
                    .substring(0, 1)
                    .toUpperCase(), // Prend la première lettre du prénom
                style: TextStyle(
                  fontSize: 38, // Taille de la lettre
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Couleur de la lettre
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Prénom',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF8C8C8C),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: prenomController,
                    onChanged: (prenom) {
                      prenomController.text;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(
                                0xFFEC6294)), // Couleur de la bordure en focus
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .grey), // Couleur de la bordure lorsque non en focus
                      ),
                      hintText: prenom,
                      alignLabelWithHint: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Nom',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF8C8C8C),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (nom) {},
                    controller: nomController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(
                                0xFFEC6294)), // Couleur de la bordure en focus
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .grey), // Couleur de la bordure lorsque non en focus
                      ),
                      hintText: nom,
                      alignLabelWithHint: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Email',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF8C8C8C),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (email) {},
                    controller: emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(
                                0xFFEC6294)), // Couleur de la bordure en focus
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .grey), // Couleur de la bordure lorsque non en focus
                      ),
                      hintText: email,
                      alignLabelWithHint: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  updateProfile();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFEC6294), // Couleur de fond du bouton
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Optionnel : arrondir les coins du bouton
                  ),
                ),
                child: Text(
                  'Modifier Profil',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Couleur du texte du bouton
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
