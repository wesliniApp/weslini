import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:weslini/passager/passager1.dart';
import 'dart:math';
import 'dart:async';

class InscrPassager extends StatefulWidget {
  @override
  State<InscrPassager> createState() => _InscrPassagerState();
}

String errorMessage = '';

class _InscrPassagerState extends State<InscrPassager> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  String generatedCode = '';
  Timer? codeExpirationTimer;
  final String infobipApiKey =
      '0a26c3a74b07315922aa7db0f622c921-386820c9-a2a4-4d95-b330-3ff98461ad84';
  final String senderNumber = 'Wesslini';
  final List<String> sexe = ['Femme', 'Homme'];
  String selectedSexe = 'Femme';

  @override
  @override
  void initState() {
    super.initState();
    generatedCode = generateRandomCode();
    codeController.text = generatedCode;
    startCodeExpirationTimer();
    print(generatedCode); // Afficher le code généré dans le terminal
  }

  @override
  void dispose() {
    codeExpirationTimer?.cancel();
    super.dispose();
  }

  String generateRandomCode() {
    final random = Random();
    int code = 100000 + random.nextInt(900000);
    print(code);
    return code.toString();
  }

  Future<void> sendSms(
      BuildContext context, String recipientNumber, String message) async {
    final modifiedRecipientNumber = recipientNumber.replaceFirst('0', '213');
    ;
    print(generatedCode);
    final url = 'https://api.infobip.com/sms/1/text/single';
    final headers = {
      'Authorization': 'App $infobipApiKey',
      'Content-Type': 'application/json',
    };

    final body = {
      'from': senderNumber,
      'to': modifiedRecipientNumber,
      'text': message,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('SMS envoyé avec succès'),
            content:
                Text('Le SMS a été envoyé avec succès à $recipientNumber.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      startCodeExpirationTimer();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur lors de l\'envoi du SMS'),
            content:
                Text('Une erreur s\'est produite lors de l\'envoi du SMS.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void changeGeneratedCode() {
    setState(() {
      generatedCode = generateRandomCode();
      codeController.text = generatedCode;
      print(generatedCode);
    });

    // Appeler startCodeExpirationTimer pour redémarrer le timer
  }

  void startCodeExpirationTimer() {
    codeExpirationTimer?.cancel();

    codeExpirationTimer = Timer(Duration(seconds: 60), () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Code expiré'),
            content: Text(
                'Le code de vérification a expiré. Veuillez demander un nouveau code.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1940), // Date de début en 1940
      firstDate: DateTime(1940), // Date de début en 1940
      lastDate: DateTime(2005, 1, 1), // Date de fin en 2005-01-01
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFFEC6294),
            hintColor: Color(0xFFEC6294),
            colorScheme: ColorScheme.light(primary: Color(0xFFEC6294)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != DateTime.now()) {
      var formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      dateController.text = formattedDate;
    }
  }

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _passwordsMatch = true;

  Future<void> registerUser(BuildContext context) async {
    final String nom =
        nomController.text; // Remplacez par le nom de l'utilisateur
    final String prenom = prenomController.text;
    final String email = emailController.text;
    final String numeroTelephone =
        phoneController.text.replaceFirst('0', '213');

    // Récupérez le numéro de téléphone à partir du contrôleur
    final String dateNaissance = dateController
        .text; // Récupérez la date de naissance à partir du contrôleur
    final String sexe = selectedSexe;
    final String password = _passwordController
        .text; // Récupérez le mot de passe à partir du contrôleur

    final Map<String, dynamic> userData = {
      "nom": nom,
      "prenom": prenom,
      "email": email,
      "numero_telephone": numeroTelephone,
      "date_de_naissance": dateNaissance,
      "sexe": sexe,
      "password": password,
    };

    final String url =
        'http://192.168.1.5:8080/utilisateurs'; // Remplacez par l'URL de votre backend

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      // Naviguer vers l'écran de vérification du code
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationCodeScreen(generatedCode),
        ),
      );

      sendSms(context, phoneController.text, generatedCode);
    } else {
      // L'inscription a échoué, affichez un message d'erreur.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur d\'inscription'),
            content: Text('Vous avez déjà un compte sur Wesslini'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> validatePassager(BuildContext context, String passagerID) async {
    final String url =
        'http://192.168.1.4:8080/validatePassager/$passagerID'; // Remplacez par l'URL de votre backend

    final response = await http.put(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      // La validation du passager a réussi
      // Vous pouvez afficher un message de succès ou effectuer d'autres actions nécessaires
    } else if (response.statusCode == 404) {
      // Le passager n'a pas été trouvé, affichez un message d'erreur
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Passager non trouvé'),
            content:
                Text('Le passager que vous essayez de valider n\'existe pas.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // Une erreur s'est produite lors de la validation du passager, affichez un message d'erreur
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur lors de la validation du passager'),
            content: Text(
                'Une erreur s\'est produite lors de la validation du passager.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    'Créer votre compte',
                    style: TextStyle(
                      color: Color(0xFFEC6294),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: prenomController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFEC6294),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        labelText: 'Prénom',
                        hintText: 'Saisissez votre prénom',
                        alignLabelWithHint: false,
                        labelStyle: TextStyle(
                          color: Color(0xFF979797),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: nomController,
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
                        hintText: "Saisissez votre nom",
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          color: Color(0xFF979797),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      onChanged: (email) {},
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFEC6294)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        labelText: "Email",
                        hintText: "Saisissez votre email",
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          color: Color(0xFF979797),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: phoneController,
                      onChanged: (numero) {},
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 12,
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
                  ],
                ),
              ),
              SizedBox(
                height: 5,
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
                            color: Color(0xFFEC6294),
                          ),
                        ),
                        hintText: 'Sélectionnez une date',
                        labelText: 'Date de naissance',
                        labelStyle: TextStyle(
                          color: Color(0xFF979797),
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
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      hint: Text('Sexe'),
                      //value: selectedSexe,
                      onChanged: (newValue) {
                        if (newValue == "Homme") {
                          // Si "Homme" est sélectionné, définissez le message d'erreur.
                          setState(() {
                            errorMessage =
                                "Inscription interdite pour les hommes";
                          });
                        } else {
                          // Réinitialisez le message d'erreur si l'utilisateur fait un autre choix.
                          setState(() {
                            errorMessage = "";
                            selectedSexe = newValue!;
                          });
                        }
                      },
                      items: sexe.map((sexe) {
                        return DropdownMenuItem<String>(
                          value: sexe,
                          child: Text(sexe),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFEC6294)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    if (errorMessage.isNotEmpty)
                      Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _passwordController,
                      onChanged: (password) {
                        setState(() {
                          _passwordsMatch =
                              password == _confirmPasswordController.text;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFEC6294)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        labelText: "Mot de passe",
                        hintText: "Saisissez votre mot de passe",
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          color: Color(0xFF979797),
                        ),
                      ),
                      obscureText: true, // Cette ligne masquera le texte saisi
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _confirmPasswordController,
                      onChanged: (confirmPassword) {
                        setState(() {
                          _passwordsMatch =
                              confirmPassword == _passwordController.text;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFEC6294)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        labelText: "Confirmer mot de passe",
                        hintText: "Confirmez votre mot de passe",
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          color: Color(0xFF979797),
                        ),
                      ),
                      obscureText: true,
                    ),
                    if (!_passwordsMatch)
                      Text(
                        textAlign: TextAlign.left,
                        "Les mots de passe ne correspondent pas",
                        style: TextStyle(
                          color: Colors.red,
                          // Cette ligne aligne le texte à gauche
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: (phoneController.text.isNotEmpty &&
                            _passwordsMatch &&
                            selectedSexe != "Homme")
                        ? () {
                            registerUser(context);
                          }
                        : null, // Désactiver le bouton si les mots de passe ne correspondent pas
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFEC6294),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Inscription',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class VerificationCodeScreen extends StatefulWidget {
  final String generatedCode;

  VerificationCodeScreen(this.generatedCode);

  @override
  _VerificationCodeScreenState createState() =>
      _VerificationCodeScreenState(generatedCode);
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final String generatedCode;
  final TextEditingController verificationCodeController =
      TextEditingController();

  _VerificationCodeScreenState(this.generatedCode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEC6294),
        title: Text('Vérification du Code'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 60),
              Text(
                  'Un code de vérification a été envoyé à votre numéro de téléphone.'),
              SizedBox(height: 30),
              TextFormField(
                controller: verificationCodeController,
                decoration: InputDecoration(
                  labelText: 'Code de vérification',
                  hintText: 'Saisissez votre code de vérification',
                  alignLabelWithHint: false,
                  labelStyle: TextStyle(
                    color: Color(0xFF979797),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEC6294)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFEC6294),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    // Vérifiez le code ici
                    if (verificationCodeController.text == generatedCode) {
                      // Le code est correct, redirigez l'utilisateur vers PassagerHome
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PassagerHome()),
                      );
                    } else {
                      // Le code est incorrect, affichez un message d'erreur
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Code Incorrect'),
                            content:
                                Text('Le code de vérification est incorrect.'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFEC6294),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      ),
    );
  }
}
