import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:weslini/home.dart';
import 'package:weslini/passager/question.dart';

class Aide extends StatefulWidget {
  const Aide({super.key});

  @override
  State<Aide> createState() => _AideState();
}

class _AideState extends State<Aide> {
  _launchPhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible d\'ouvrir l\'application d\'appel téléphonique';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEC6294),
        title: Text(
          "Centre d'aide",
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
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor:
                      Color(0xFF8C8C8C), // Couleur de fond du cercle
                  radius: 20, // Rayon du cercle
                  child: Icon(
                    Icons.chat_sharp,
                    color: Colors.white,
                  ),
                ),
                // Icône
                SizedBox(width: 20), // Espace entre l'icône et la colonne
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Discussion directe',
                        style: TextStyle(
                            color: Color(0xFF8C8C8C),
                            fontWeight: FontWeight.bold,
                            fontSize: 16)), // Premier texte
                    Text('Chat instantané avec Weslini',
                        style: TextStyle(
                            color: Color(0xFF8C8C8C),
                            fontWeight: FontWeight.normal,
                            fontSize: 14)), // Deuxième texte
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              _launchPhoneCall('0559417723');
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Color(0xFF8C8C8C), // Couleur de fond du cercle
                    radius: 20, // Rayon du cercle
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                  ),
                  // Icône
                  SizedBox(width: 20), // Espace entre l'icône et la colonne
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Assistance télephonique',
                          style: TextStyle(
                              color: Color(0xFF8C8C8C),
                              fontWeight: FontWeight.bold,
                              fontSize: 16)), // Premier texte
                      Text('Disponible 24/24 heures',
                          style: TextStyle(
                              color: Color(0xFF8C8C8C),
                              fontWeight: FontWeight.normal,
                              fontSize: 14)), // Deuxième texte
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ExpandableTextWidget(), // Remplacez par votre propre page de questions
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Color(0xFF8C8C8C), // Couleur de fond du cercle
                    radius: 20, // Rayon du cercle
                    child: Icon(
                      Icons.question_mark,
                      color: Colors.white,
                    ),
                  ),
                  // Icône
                  SizedBox(width: 20), // Espace entre l'icône et la colonne
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Questions fréquentes',
                          style: TextStyle(
                              color: Color(0xFF8C8C8C),
                              fontWeight: FontWeight.bold,
                              fontSize: 16)), // Premier texte
                      Text('Trouvez des réponses a vos questions',
                          style: TextStyle(
                              color: Color(0xFF8C8C8C),
                              fontWeight: FontWeight.normal,
                              fontSize: 14)), // Deuxième texte
                    ],
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
