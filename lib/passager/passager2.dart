import 'package:flutter/material.dart';
import 'package:weslini/passager/vehicule.dart';

class FormDestination extends StatefulWidget {
  const FormDestination({super.key});

  @override
  State<FormDestination> createState() => _FormDestinationState();
}

class _FormDestinationState extends State<FormDestination> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              child: Column(children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  backgroundColor: Color(0xFFEC6294),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // Retour à la page précédente
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 16.0), // Ajustez la valeur selon vos besoins
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Où allez-vous ?',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFEC6294),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 16.0), // Adjust the margins as needed
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Votre position',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEC6294)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEC6294)),
                  ),
                  prefixIcon: Icon(
                    Icons.pin_drop,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 16.0), // Adjust the margins as needed
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Votre destination',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEC6294)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEC6294)),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 16.0), // Adjust the margins as needed
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEC6294)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEC6294)),
                  ),
                  prefixIcon: Icon(
                    Icons.text_fields,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFEC6294), // Couleur de fond du bouton
                padding: EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Optionnel : arrondir les coins du bouton
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Vehicule()), // Remplacez 'PageVoiture' par le nom de votre page de voiture
                );
              },
              child: Text(
                'Valider',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ]))
        ])));
  }
}
