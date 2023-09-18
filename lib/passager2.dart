import 'package:flutter/material.dart';

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
                primary: Color(0xFFEC6294), // Background color
                onPrimary: Colors.white, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Border radius
                ),
              ),
              onPressed: () {
                // Your button's onPressed callback
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
