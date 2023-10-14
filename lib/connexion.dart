import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  String phoneNumber = '';
  String verificationCode = '';
  bool isVerifying = false;

  // Function to handle the "Confirmer" button press
  void confirmButtonPressed() async {
    setState(() {
      isVerifying = true;
    });

    // Simulate sending the phone number to the backend and receiving a verification code
    // Replace this with actual backend API calls

    await Future.delayed(Duration(seconds: 2)); // Simulate a delay

    // For simplicity, we'll simulate receiving a verification code from the backend
    verificationCode = '123456';

    setState(() {
      isVerifying = false;
    });

    // Display a screen to enter the verification code received via SMS
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationScreen(
          phoneNumber: phoneNumber,
          verificationCode: verificationCode,
        ),
      ),
    );
  }

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
                  color: Color(0xFFEC6294),
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
                      onChanged: (numero) {
                        phoneNumber = numero;
                      },
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
                        hintText: "Saisissez votre numéro de téléphone",
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
                      "Saisissez votre numéro de téléphone utilisé lors de l'inscription",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF979797),
                      ),
                    ),
                    SizedBox(
                      height: 310,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: isVerifying ? null : confirmButtonPressed,
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFEC6294),
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
}

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationCode;

  VerificationScreen(
      {required this.phoneNumber, required this.verificationCode});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String enteredCode = '';

  // Function to handle verifying the code entered by the user
  void verifyCode() async {
    // Send the entered verification code and phone number to the backend for verification
    // Handle the response from the backend

    // If verification is successful, proceed with user authentication
  }

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
                "Entrez le code de vérification",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEC6294),
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
                      onChanged: (code) {
                        enteredCode = code;
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 6,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFEC6294)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        labelText: "Code de vérification",
                        hintText: "Saisissez le code reçu par SMS",
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          color: Color(0xFF979797),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: verifyCode,
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFEC6294),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Vérifier',
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
}
