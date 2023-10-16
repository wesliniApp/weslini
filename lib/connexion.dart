import 'package:weslini/home.dart';
import 'package:weslini/rest_api.dart';
import 'package:weslini/form_fields_widgets.dart';
import 'package:flutter/material.dart';

class Connexion extends StatefulWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          FormFields(
                            controller: _numeroController,
                            data: Icons.phone,
                            txtHint: "numero de telephone",
                            obsecure: false,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormFields(
                            controller: _passwordController,
                            data: Icons.phone,
                            txtHint: "mot de passe",
                            obsecure: false,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Saisi votre numéro de téléphone utilisé lors de l'inscription ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(
                                0xFF979797,
                              ), // Couleur du texte du bouton
                            ),
                          ),
                          SizedBox(
                            height: 200,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          _numeroController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty
                              ? doLogin(context, _numeroController.text,
                                  _passwordController.text)
                              : showSnackBar(context,
                                  "remplissez les champs s'il vous plis");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFEC6294),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
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

  Future<void> doLogin(
      BuildContext context, String numero, String password) async {
    var res = await userLogin(numero.trim(), password.trim());
    if (res['success']) {
      Route route = MaterialPageRoute(builder: (_) => Home());
      Navigator.pushReplacement(context, route);
    } else {
      showSnackBar(context, "numero de telephone ou mot de passe incorrecte");
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
}
