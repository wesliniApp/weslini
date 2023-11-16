import 'package:flutter/material.dart';

class ProfileChauffeur extends StatefulWidget {
  const ProfileChauffeur({super.key});

  @override
  State<ProfileChauffeur> createState() => _ProfileChauffeurState();
}

class _ProfileChauffeurState extends State<ProfileChauffeur> {
  get prenom => "nadjet";
  get nom => "bm";

  get email => "nadjet@gmail.com";

  final List<String> genre = ['Femme', 'Homme'];
  String selectedGender = 'Femme';
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
                  // Mettez ici votre logique d'inscription
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
