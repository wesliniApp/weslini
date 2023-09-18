import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InscrPassager extends StatefulWidget {
  final TextEditingController dateController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(
          DateTime.now().year + 10), // Limit dates to the next 10 years
    );
    if (picked != null && picked != DateTime.now()) {
      var DateFormat;
      dateController.text = DateFormat.yMMMd().format(picked);
    }
  }

  @override
  State<InscrPassager> createState() => _InscrPassagerState();
}

class _InscrPassagerState extends State<InscrPassager> {
  @override
  Widget build(BuildContext context) {
    var dateController;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFFEC6294),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Container(
              width: 150, // Largeur souhaitée de l'image

              child: Image.asset(
                  'assets/logopink.png'), // Utilisation de l'image depuis les assets
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.centerLeft,
              child: Text('Créer votre compte',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF8C8C8C),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
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
                      labelText: 'Prenom',
                      hintText: 'Saisi votre prenom',
                      alignLabelWithHint: false,
                      labelStyle: TextStyle(
                        color: Color(0xFF979797),
                        fontWeight: FontWeight.bold,
                      ),
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
                  TextFormField(
                    onChanged: (nom) {},
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEC6294)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      labelText: "Nom",
                      hintText: "Saisi votre nom",
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(
                        color: Color(0xFF979797),
                        fontWeight: FontWeight.bold,
                      ),
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
                  TextFormField(
                    onChanged: (numero) {},
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                        fontWeight: FontWeight.bold,
                      ),
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
                  TextFormField(
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
                      labelText: "Email",
                      hintText: 'Saisi votre email',
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(
                        color: Color(0xFF979797),
                        fontWeight: FontWeight.bold,
                      ),
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
                  TextFormField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEC6294)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(
                                0xFFEC6294)), // Couleur de la bordure en focus
                      ),
                      hintText: 'Selectioner une date',
                      labelText: 'Date de naissance',
                      labelStyle: TextStyle(
                        color: Color(0xFF979797),
                        fontWeight: FontWeight.bold,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Color(0xFF8C8C8C),
                        ),
                        onPressed: () {
                          _selectDate(context);
                        },
                      ),
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
                  'Inscription',
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

  void _selectDate(BuildContext context) {}
}
