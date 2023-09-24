import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:weslini/passager/passager1.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBEDF2),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Text(
                "Quelle est votre numéro de téléphone ?",
                style: TextStyle(
                  fontSize: 26,

                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEC6294), // Couleur du texte du bouton
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      onChanged: (numero) {},
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 10,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFEC6294)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        labelText: "Numéro de téléphone",
                        hintText: "Saisi votre numéro de téléphone",
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          color: Color(0xFF979797),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Saisi votre numéro de téléphone utilisé lors de l'inscription ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF979797), // Couleur du texte du bouton
                      ),
                    ),
                    SizedBox(
                      height: 310,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to PassagerHome
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PassagerHome()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                              Color(0xFFEC6294), // Couleur de fond du bouton
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Optionnel : arrondir les coins du bouton
                          ),
                        ),
                        child: Text(
                          'Confirmer',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white, // Couleur du texte du bouton
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
    );
  }
}
