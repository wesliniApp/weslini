import 'dart:convert';

import 'package:weslini/home.dart';
import 'package:weslini/backend/rest_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'dart:async';
import 'package:weslini/backend/utils.dart';

BuildContext? globalContext;

class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
  //sms
}

class _MyFormState extends State<MyForm> {
  TextEditingController numeroController = TextEditingController();
  final String infobipApiKey =
      '0a26c3a74b07315922aa7db0f622c921-386820c9-a2a4-4d95-b330-3ff98461ad84';
  final String senderNumber = 'Wesslini';

  String generateRandomCode() {
    final random = Random();
    final randomCode = (1000 + random.nextInt(9000)).toString();
    return randomCode;
  }

  Future<void> sendSms(
      BuildContext context, String recipientNumber, String message) async {
    final modifiedRecipientNumber = recipientNumber.replaceFirst('0', '213');

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
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: globalContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('SMS envoyé avec succès'),
            content:
                Text('Le SMS a été envoyé avec succès à $recipientNumber.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(globalContext!).pop();
                },
              ),
            ],
          );
        },
      );
      print('Random Code: $message');
    } else {
      showDialog(
        context: globalContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur lors de l\'envoi du SMS'),
            content:
                Text('Une erreur s\'est produite lors de l\'envoi du SMS.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(globalContext!).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // ... Your other methods ...

  bool messageNum = true; // Initialisez messageNum à true par défaut

  Future<void> testNum(String numeroTelephone) async {
    final res = await sendRequest(numeroTelephone.trim());
    if (res['success']) {
      setState(() {
        messageNum = true;
      });
    } else {
      setState(() {
        messageNum = false;
      });
    }
  }

  bool messagePlaque = true; // Initialisez messageNum à true par défaut

  Future<void> testPlaque(String plaque) async {
    final res = await sendRequestPlaque(plaque.trim());
    if (res['success']) {
      setState(() {
        messagePlaque = true;
      });
    } else {
      setState(() {
        messagePlaque = false;
      });
    }
  }

  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294);
  Color btngreyColor = Color(0xFF8C8C8C);
  Color textColorBlack = Color.fromARGB(255, 46, 46, 46);
  PageController _pageController = PageController();
  int _currentPage = 0;

  bool passwordsMatch = true;

  final TextEditingController _nom = TextEditingController();
  final TextEditingController _prenom = TextEditingController();
  final TextEditingController _numero = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _sexe = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final TextEditingController _marque = TextEditingController();
  final TextEditingController _annee = TextEditingController();
  final TextEditingController _couleur = TextEditingController();
  final TextEditingController _motorisation = TextEditingController();
  final TextEditingController _plaque = TextEditingController();
  final TextEditingController _ville = TextEditingController();
  final TextEditingController _wilaya = TextEditingController();
  final TextEditingController _daira = TextEditingController();
  final TextEditingController _commune = TextEditingController();

  final TextEditingController _permisrecto = TextEditingController();
  final TextEditingController _permisverso = TextEditingController();
  final TextEditingController _identite = TextEditingController();
  final TextEditingController _grise = TextEditingController();
  final TextEditingController _assurance = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                Page1(
                    nomController: _nom,
                    prenomController: _prenom,
                    numeroController: _numero,
                    emailController: _email,
                    dateController: _date,
                    sexeController: _sexe,
                    villeController: _ville,
                    wilayaController: _wilaya,
                    dairaController: _daira,
                    communeController: _commune,
                    passwordController: _password,
                    confirmPasswordController: _confirmPassword,
                    passwordsMatch: passwordsMatch,
                    messageNum: messageNum,
                    testNum: testNum,
                    updateSexe: (newValue) {
                      setState(() {
                        _sexe.text = newValue;
                      });
                    },
                    updateWilaya: (newValue) {
                      setState(() {
                        _wilaya.text = newValue;
                      });
                    },
                    updateDaira: (newValue) {
                      setState(() {
                        _daira.text = newValue;
                      });
                    },
                    updateCommune: (newValue) {
                      setState(() {
                        _commune.text = newValue;
                      });
                    },
                    pass: (password) {
                      setState(() {
                        passwordsMatch = password == _confirmPassword.text;
                      });
                    },
                    confirmPass: (confirmPassword) {
                      setState(() {
                        passwordsMatch = confirmPassword == _password.text;
                      });
                    }),
                Page2(
                  marqueController: _marque,
                  anneeController: _annee,
                  couleurController: _couleur,
                  motorisationController: _motorisation,
                  plaqueController: _plaque,
                  updateMarque: (newValue) {
                    setState(() {
                      _marque.text = newValue;
                    });
                  },
                  updateAnnee: (newValue) {
                    setState(() {
                      _annee.text = newValue;
                    });
                  },
                  updateCouleur: (newValue) {
                    setState(() {
                      _couleur.text = newValue;
                    });
                  },
                  updateMotorisation: (newValue) {
                    setState(() {
                      _motorisation.text = newValue;
                    });
                  },
                  nomController: _nom,
                  prenomController: _prenom,
                  numeroController: _numero,
                  emailController: _email,
                  dateController: _date,
                  sexeController: _sexe,
                  passwordController: _password,
                  testPlaque: testPlaque,
                  messagePlaque: messagePlaque,
                ),
                Page3(
                  permisrectoController: _permisrecto,
                  permisversoController: _permisverso,
                  identiteController: _identite,
                  griseController: _grise,
                  assuranceController: _assurance,
                  marqueController: _marque,
                  anneeController: _annee,
                  couleurController: _couleur,
                  motorisationController: _motorisation,
                  plaqueController: _plaque,
                  villeController: _ville,
                  wilayaController: _wilaya,
                  dairaController: _daira,
                  communeController: _commune,
                  nomController: _nom,
                  prenomController: _prenom,
                  numeroController: _numero,
                  emailController: _email,
                  dateController: _date,
                  sexeController: _sexe,
                  passwordController: _password,
                  passwordsMatch: passwordsMatch,
                  registerCallback: doRegister,
                  alertCallback: showSnackBar,
                  generateRandomCode: generateRandomCode,
                  sendSms: sendSms,
                  messageNum: messageNum,
                  testPlaque: testPlaque,
                  messagePlaque: messagePlaque,
                  updatePermisverso: (file) {
                    setState(() {
                      _permisverso.text = file;
                    });
                  },
                  updatePermisrecto: (file) {
                    setState(() {
                      _permisrecto.text = file;
                    });
                  },
                  updateIdentite: (file) {
                    setState(() {
                      _identite.text = file;
                    });
                  },
                  updateGrise: (file) {
                    setState(() {
                      _grise.text = file;
                    });
                  },
                  updateAssurance: (file) {
                    setState(() {
                      _assurance.text = file;
                    });
                  },
                ),
              ],
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              if (_currentPage > 0)
                ElevatedButton(
                  onPressed: () {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Icon(Icons.arrow_back),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btngreyColor,
                  ),
                ),
              SizedBox(
                width: 20.0,
              ),
              if (_currentPage <
                  2) // Only allow going forward if there are more pages
                ElevatedButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Icon(Icons.arrow_forward),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                ),
              SizedBox(
                width: 20.0,
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  Future<void> doRegister(
    BuildContext context,
    String nom,
    String prenom,
    String numero,
    String email,
    String date,
    String sexe,
    String password,
    String marque,
    String annee,
    String couleur,
    String motorisation,
    String plaque,
    String ville,
    String wilaya,
    String daira,
    String commune,
    String permisrecto,
    String permisverso,
    String identite,
    String grise,
    String assurance,
  ) async {
    var res = await userRegister(
        nom.trim(),
        prenom.trim(),
        numero.trim(),
        email.trim(),
        date.trim(),
        sexe.trim(),
        password.trim(),
        marque.trim(),
        annee.trim(),
        couleur.trim(),
        motorisation.trim(),
        plaque.trim(),
        ville.trim(),
        wilaya.trim(),
        daira.trim(),
        commune.trim(),
        permisrecto.trim(),
        permisverso.trim(),
        identite.trim(),
        grise.trim(),
        assurance.trim());
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

class Page1 extends StatelessWidget {
  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294);
  Color btngreyColor = Color(0xFF8C8C8C);
  Color textColorBlack = Color.fromARGB(255, 46, 46, 46);
  String message = "";

  final bool passwordsMatch;

  final TextEditingController nomController;
  final TextEditingController prenomController;
  final TextEditingController numeroController;
  final bool messageNum; // Message à affiche
  final TextEditingController emailController;
  final TextEditingController dateController;
  final TextEditingController sexeController;
  final TextEditingController villeController;
  final TextEditingController wilayaController;
  final TextEditingController dairaController;
  final TextEditingController communeController;

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final Function(String) testNum;
  final Function(String) pass;
  final Function(String) confirmPass;

  final Function(String) updateSexe;
  final Function(String) updateWilaya;
  final Function(String) updateDaira;
  final Function(String) updateCommune;

  Page1(
      {required this.nomController,
      required this.prenomController,
      required this.numeroController,
      required this.emailController,
      required this.dateController,
      required this.sexeController,
      required this.villeController,
      required this.wilayaController,
      required this.dairaController,
      required this.communeController,
      required this.passwordController,
      required this.confirmPasswordController,
      required this.passwordsMatch,
      required this.pass,
      required this.confirmPass,
      required this.updateSexe,
      required this.updateWilaya,
      required this.updateDaira,
      required this.updateCommune,
      required this.testNum,
      required this.messageNum});

  Future sendRequest(String numeroTelephone) async {
    final Uri url = Uri.parse('${Utils.baseUrl}/user/testNum');
    final Map<String, dynamic> requestBody = {
      'numero_telephone': numeroTelephone,
    };
    print(requestBody);

    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json", // Set the content-type to JSON
      },
      body: jsonEncode(requestBody), // Encode the body as JSON
    );

    var decodeData = jsonDecode(response.body);
    return decodeData;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1955), // Date de début en 1955
      firstDate: DateTime(1955), // Date de début en 1955
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String? selectedFileName;

    final List<String> sexe = ['Femme', 'Homme'];
    String? selectedSexe;

    final List<String> wilaya = ['alger', 'boumerdes', 'chlef'];
    String? selectedWilaya;

    final List<String> daira = ['alger', 'boumerdes', 'chlef'];
    String? selectedDaira;

    final List<String> commune = ['alger', 'boumerdes', 'chlef'];
    String? selectedCommune;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Text(
              "Inscrivez-vous",
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColorBlack,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(
              "Informations de conducteur",
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: nomController,
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: primaryColor,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nom',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: TextField(
                      controller: prenomController,
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: primaryColor,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Prenom',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: emailController,
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: primaryColor,
                ),
                decoration: InputDecoration(
                  hintText: 'Email',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  TextField(
                    controller: numeroController,
                    style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    onChanged: (numeroTelephone) {
                      testNum(numeroTelephone);
                    },
                    maxLength: 12,
                    decoration: InputDecoration(
                      hintText: 'Numero de téléphone',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink),
                      ),
                    ),
                  ),
                  if (!messageNum)
                    Text(
                      "Vous avez deja un compte chauffeur avec ce numero",
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0),

          // Display the message outside the TextField
          Center(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  TextField(
                    controller: passwordController,
                    onChanged: (password) {
                      pass(password);
                    },
                    style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: primaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: 'password',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink),
                      ),
                    ),
                  ),
                  if (passwordController.text.isNotEmpty &&
                      passwordController.text.length < 8)
                    Text(
                      'Le mot de passe doit contenir au moins 8 caractères.',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 20.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: confirmPasswordController,
                  onChanged: (confirmPassword) {
                    confirmPass(confirmPassword);
                  },
                  decoration: InputDecoration(
                    hintText: 'Confirmez votre mot de passe',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink),
                    ),
                  ),
                ),
                if (!passwordsMatch)
                  Text(
                    "Les mots de passe ne correspondent pas",
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: Column(
                children: <Widget>[
                  DropdownButtonFormField<String>(
                    hint: Text('quel est votre sexe'),
                    value: selectedSexe,
                    onChanged: (newValue) {
                      updateSexe(newValue!);
                      print(
                          sexeController.text); // Call the updateSexe function
                    },
                    items: sexe.map((sexe) {
                      return DropdownMenuItem<String>(
                        value: sexe,
                        child: Text(sexe),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFEC6294),
                        ),
                      ),
                    ),
                  ),
                  if (sexeController.text == 'Homme')
                    Text(
                      'Inscription interdite pour les hommes',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: villeController,
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: primaryColor,
                ),
                decoration: InputDecoration(
                  hintText: 'votre adresse',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: DropdownButtonFormField<String>(
                hint: Text('quel est votre wilaya'),
                value: selectedWilaya, // Use the selectedSexe variable
                onChanged: (newValue) {
                  updateWilaya(newValue!); // Call the updateSexe function
                },
                items: wilaya.map((wilaya) {
                  return DropdownMenuItem<String>(
                    value: wilaya,
                    child: Text(wilaya),
                  );
                }).toList(),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFEC6294),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: DropdownButtonFormField<String>(
                hint: Text('quel est votre daira'),
                value: selectedDaira, // Use the selectedSexe variable
                onChanged: (newValue) {
                  updateDaira(newValue!); // Call the updateSexe function
                },
                items: daira.map((daira) {
                  return DropdownMenuItem<String>(
                    value: daira,
                    child: Text(daira),
                  );
                }).toList(),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFEC6294),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: DropdownButtonFormField<String>(
                hint: Text('quel est votre commune'),
                value: selectedCommune, // Use the selectedSexe variable
                onChanged: (newValue) {
                  updateCommune(newValue!); // Call the updateSexe function
                },
                items: commune.map((commune) {
                  return DropdownMenuItem<String>(
                    value: commune,
                    child: Text(commune),
                  );
                }).toList(),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFEC6294),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: dateController,
                readOnly: true,
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: primaryColor,
                ),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
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
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294);
  Color btngreyColor = Color(0xFF8C8C8C);
  Color textColorBlack = Color.fromARGB(255, 46, 46, 46);

  final TextEditingController marqueController;
  final TextEditingController anneeController;
  final TextEditingController couleurController;
  final TextEditingController motorisationController;
  final TextEditingController plaqueController;
  final Function(String) updateMarque;
  final Function(String) updateAnnee;
  final Function(String) updateCouleur;
  final Function(String) updateMotorisation;
  final Function(String) testPlaque;

  final TextEditingController nomController;
  final TextEditingController prenomController;
  final TextEditingController numeroController;
  final TextEditingController emailController;
  final TextEditingController dateController;
  final TextEditingController sexeController;
  final TextEditingController passwordController;
  final bool messagePlaque;

  Page2({
    //p3
    required this.marqueController,
    required this.anneeController,
    required this.couleurController,
    required this.motorisationController,
    required this.plaqueController,
    required this.updateMarque,
    required this.updateAnnee,
    required this.updateCouleur,
    required this.updateMotorisation,
    required this.nomController,
    required this.prenomController,
    required this.numeroController,
    required this.emailController,
    required this.dateController,
    required this.sexeController,
    required this.passwordController,
    required this.messagePlaque,
    required this.testPlaque,
  });
  Future sendRequesty(String numeroTelephone) async {
    final Uri url = Uri.parse('${Utils.baseUrl}/user/testNum');
    final Map<String, dynamic> requestBody = {
      'numero_telephone': numeroTelephone,
    };
    print(requestBody);

    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json", // Set the content-type to JSON
      },
      body: jsonEncode(requestBody), // Encode the body as JSON
    );

    var decodeData = jsonDecode(response.body);
    return decodeData;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String? selectedFileName;

    final List<String> marque = ['gonow', 'bmw', 'cherry'];
    String? selectedMarque;

    final List<String> annee = ['2020', '2010', '2003'];
    String? selectedAnnee;

    final List<String> couleur = ['grise', 'rouge', 'blanche'];
    String? selectedCouleur;

    final List<String> motorisation = ['none', 'dsel', 'essence'];
    String? selectedMotorisation;
    return Scaffold(
        body: ListView(children: <Widget>[
      SizedBox(
        height: 40.0,
      ),
      Center(
        child: Text(
          "Information de vehicule",
          style: TextStyle(
            fontFamily: 'inter',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ),
      SizedBox(
        height: 40.0,
      ),
      Center(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          width: screenWidth,
          child: DropdownButtonFormField<String>(
            hint: Text('quel est la marque de vehicule'),
            value: selectedMarque, // Use the selectedSexe variable
            onChanged: (newValue) {
              updateMarque(newValue!); // Call the updateSexe function
            },
            items: marque.map((marque) {
              return DropdownMenuItem<String>(
                value: marque,
                child: Text(marque),
              );
            }).toList(),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEC6294),
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 40.0,
      ),
      Center(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          width: screenWidth,
          child: DropdownButtonFormField<String>(
            hint: Text('quel est l annee de vehicule'),
            value: selectedAnnee, // Use the selectedSexe variable
            onChanged: (newValue) {
              updateAnnee(newValue!); // Call the updateSexe function
            },
            items: annee.map((annee) {
              return DropdownMenuItem<String>(
                value: annee,
                child: Text(annee),
              );
            }).toList(),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEC6294),
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 40.0,
      ),
      Center(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          width: screenWidth,
          child: DropdownButtonFormField<String>(
            hint: Text('quel est la couleur de vehicule'),
            value: selectedCouleur, // Use the selectedSexe variable
            onChanged: (newValue) {
              updateCouleur(newValue!); // Call the updateSexe function
            },
            items: couleur.map((couleur) {
              return DropdownMenuItem<String>(
                value: couleur,
                child: Text(couleur),
              );
            }).toList(),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEC6294),
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 40.0,
      ),
      Center(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          width: screenWidth,
          child: DropdownButtonFormField<String>(
            hint: Text('Motorisation'),
            value: selectedMotorisation, // Use the selectedSexe variable
            onChanged: (newValue) {
              updateMotorisation(newValue!); // Call the updateSexe function
            },
            items: motorisation.map((motorisation) {
              return DropdownMenuItem<String>(
                value: motorisation,
                child: Text(motorisation),
              );
            }).toList(),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEC6294),
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Center(
        child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                TextField(
                  controller: plaqueController,
                  style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: primaryColor,
                  ),
                  onChanged: (plaque) {
                    testPlaque(plaque);
                  },
                  decoration: InputDecoration(
                      hintText: 'Plaque d\'immatriculation',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink),
                      ) // C'est le placeholder
                      ),
                ),
                if (!messagePlaque)
                  Text(
                    "Vous avez deja un compte chauffeur avec ce numero",
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            )),
      ),
      SizedBox(
        height: 40.0,
      ),
    ]));
  }
}

class Page3 extends StatelessWidget {
  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294);
  Color btngreyColor = Color(0xFF8C8C8C);
  Color textColorBlack = Color.fromARGB(255, 46, 46, 46);

  final TextEditingController permisrectoController;
  final TextEditingController permisversoController;
  final TextEditingController identiteController;
  final TextEditingController griseController;
  final TextEditingController assuranceController;

  final TextEditingController marqueController;
  final TextEditingController anneeController;
  final TextEditingController couleurController;
  final TextEditingController motorisationController;
  final TextEditingController plaqueController;
  final TextEditingController villeController;
  final TextEditingController wilayaController;
  final TextEditingController dairaController;
  final TextEditingController communeController;

  final TextEditingController nomController;
  final TextEditingController prenomController;
  final TextEditingController numeroController;
  final TextEditingController emailController;
  final TextEditingController dateController;
  final TextEditingController sexeController;
  final TextEditingController passwordController;
  final bool passwordsMatch;
  final bool messageNum;
  final bool messagePlaque;

  final Function(
      BuildContext,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String) registerCallback;
  final Function alertCallback;
  final Function generateRandomCode;
  final Function(BuildContext, String, String) sendSms;
  final Function(String) updatePermisrecto;
  final Function(String) updatePermisverso;
  final Function(String) updateIdentite; // Receive sendSms
  final Function(String) updateGrise;
  final Function(String) updateAssurance;
  final Function(String) testPlaque;

  Page3({
    required this.permisrectoController,
    required this.permisversoController,
    required this.identiteController,
    required this.griseController,
    required this.assuranceController,
    required this.marqueController,
    required this.anneeController,
    required this.couleurController,
    required this.motorisationController,
    required this.plaqueController,
    required this.villeController,
    required this.wilayaController,
    required this.dairaController,
    required this.communeController,
    required this.nomController,
    required this.prenomController,
    required this.numeroController,
    required this.emailController,
    required this.dateController,
    required this.sexeController,
    required this.passwordController,
    required this.passwordsMatch,
    required this.registerCallback,
    required this.alertCallback,
    required this.generateRandomCode,
    required this.sendSms,
    required this.updatePermisrecto,
    required this.updatePermisverso,
    required this.updateIdentite, // Receive sendSms
    required this.updateGrise,
    required this.updateAssurance,
    required this.messageNum,
    required this.messagePlaque,
    required this.testPlaque,
    // Receive sendSms
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String? selectedOptionSexe;
    String? selectedOptionVille;
    String? selectedFileName;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Text(
              "Inssérez vos carte",
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Pour aligner le label à gauche
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: PopupMenuButton<String>(
                          icon: Icon(Icons.help_outline), // Icône de question
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'help',
                                child: ListTile(
                                  title: Text('Comment importer un fichier'),
                                  onTap: () {
                                    // Afficher le popup avec l'image et les instructions ici
                                    Navigator.pop(
                                        context); // Fermer le menu contextuel
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Instructions d\'importation'),
                                          content: Column(
                                            children: [
                                              Image.asset('assets/permis1.png'),
                                              Image.asset(
                                                  'assets/permis2.jpg'), // Remplacez 'assets/import_instructions.png' par le chemin de votre image
                                              Text(
                                                  'Suivez ces instructions pour importer un fichier.'),
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Fermer la boîte de dialogue
                                              },
                                              child: Text('Fermer'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ];
                          },
                          onSelected: (String value) {
                            // Gérez d'autres actions ici si nécessaire
                          },
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Photo du permis de conduire*',
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10), // Espace entre le label et le Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: Column(
                          children: <Widget>[
                            Text(
                              permisrectoController.text.isEmpty
                                  ? 'Aucun fichier sélectionné'
                                  : permisrectoController.text,
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              permisversoController.text.isEmpty
                                  ? 'Aucun fichier sélectionné'
                                  : permisversoController.text,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Flexible(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              PlatformFile file = result.files.first;

                              // Mettez à jour le contrôleur avec le nom du fichier sélectionné
                              updatePermisrecto(file.name);

                              // Vous pouvez également stocker le chemin du fichier si nécessaire
                              String? filePath = file.path;
                            }
                          },
                          child: Text("Parcourir photo recto de permis"),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              PlatformFile file = result.files.first;

                              // Mettez à jour le contrôleur avec le nom du fichier sélectionné
                              updatePermisverso(file.name);

                              // Vous pouvez également stocker le chemin du fichier si nécessaire
                              String? filePath = file.path;
                            }
                          },
                          child: Text("Parcourir photo verso de permis"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Pour aligner le label à gauche
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: PopupMenuButton<String>(
                          icon: Icon(Icons.help_outline), // Icône de question
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'help',
                                child: ListTile(
                                  title: Text('Comment importer un fichier'),
                                  onTap: () {
                                    // Afficher le popup avec l'image et les instructions ici
                                    Navigator.pop(
                                        context); // Fermer le menu contextuel
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Instructions d\'importation'),
                                          content: Column(
                                            children: [
                                              Image.asset(
                                                  'assets/identite.png'), // Remplacez 'assets/import_instructions.png' par le chemin de votre image
                                              Text(
                                                  'Suivez ces instructions pour importer un fichier.'),
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Fermer la boîte de dialogue
                                              },
                                              child: Text('Fermer'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ];
                          },
                          onSelected: (String value) {
                            // Gérez d'autres actions ici si nécessaire
                          },
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Photo d identité*',
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10), // Espace entre le label et le Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Text(
                          identiteController.text.isEmpty
                              ? 'Aucun fichier sélectionné'
                              : identiteController.text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                primaryColor, // Couleur de fond du bouton
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              PlatformFile file = result.files.first;

                              // Mettez à jour le contrôleur avec le nom du fichier sélectionné
                              updateIdentite(file.name);

                              // Vous pouvez également stocker le chemin du fichier si nécessaire
                              String? filePath = file.path;

                              // Maintenant, le texte du contrôleur contient le nom du fichier sélectionné
                            }
                          },
                          child: Text("Parcourir"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Pour aligner le label à gauche
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: PopupMenuButton<String>(
                          icon: Icon(Icons.help_outline), // Icône de question
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'help',
                                child: ListTile(
                                  title: Text('Comment importer un fichier'),
                                  onTap: () {
                                    // Afficher le popup avec l'image et les instructions ici
                                    Navigator.pop(
                                        context); // Fermer le menu contextuel
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Instructions d\'importation'),
                                          content: Column(
                                            children: [
                                              Image.asset(
                                                  'assets/grise.jpg'), // Remplacez 'assets/import_instructions.png' par le chemin de votre image
                                              Text(
                                                  'Suivez ces instructions pour importer un fichier.'),
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Fermer la boîte de dialogue
                                              },
                                              child: Text('Fermer'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ];
                          },
                          onSelected: (String value) {
                            // Gérez d'autres actions ici si nécessaire
                          },
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Carte Grise*',
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10), // Espace entre le label et le Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Text(
                          griseController.text.isEmpty
                              ? 'Aucun fichier sélectionné'
                              : griseController.text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                primaryColor, // Couleur de fond du bouton
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              PlatformFile file = result.files.first;

                              // Mettez à jour le contrôleur avec le nom du fichier sélectionné
                              updateGrise(file.name);

                              String? filePath = file.path;
                            }
                          },
                          child: Text("Parcourir"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Pour aligner le label à gauche
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      PopupMenuButton<String>(
                        icon: Icon(Icons.help_outline), // Icône de question
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'help',
                              child: ListTile(
                                title: Text('Comment importer un fichier'),
                                onTap: () {
                                  // Afficher le popup avec l'image et les instructions ici
                                  Navigator.pop(
                                      context); // Fermer le menu contextuel
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            Text('Instructions d\'importation'),
                                        content: Column(
                                          children: [
                                            Image.asset(
                                                'assets/assurance.jpg'), // Remplacez 'assets/import_instructions.png' par le chemin de votre image
                                            Text(
                                                'Suivez ces instructions pour importer un fichier.'),
                                          ],
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  context); // Fermer la boîte de dialogue
                                            },
                                            child: Text('Fermer'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ];
                        },
                        onSelected: (String value) {
                          // Gérez d'autres actions ici si nécessaire
                        },
                      ),
                      Flexible(
                        child: Text(
                          'Carte Assurance*',
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 10), // Espace entre le label et le Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Text(
                          assuranceController.text.isEmpty
                              ? 'Aucun fichier sélectionné'
                              : assuranceController.text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                primaryColor, // Couleur de fond du bouton
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              PlatformFile file = result.files.first;

                              // Mettez à jour le contrôleur avec le nom du fichier sélectionné
                              updateAssurance(file.name);

                              String? filePath = file.path;
                            }
                          },
                          child: Text("Parcourir"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          ElevatedButton(
            onPressed: () {
              if (nomController.text.isNotEmpty &&
                  prenomController.text.isNotEmpty &&
                  numeroController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  dateController.text.isNotEmpty &&
                  sexeController.text.isNotEmpty &&
                  villeController.text.isNotEmpty &&
                  wilayaController.text.isNotEmpty &&
                  dairaController.text.isNotEmpty &&
                  communeController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty &&
                  permisversoController.text.trim().isNotEmpty &&
                  permisrectoController.text.trim().isNotEmpty &&
                  identiteController.text.trim().isNotEmpty &&
                  griseController.text.trim().isNotEmpty &&
                  assuranceController.text.trim().isNotEmpty) {
                if (passwordsMatch) {
                  if (sexeController.text == 'Femme') {
                    if (messageNum) {
                      if (!(passwordController.text.length < 8)) {
                        if (messagePlaque) {
                          globalContext = context;
                          final randomCode = generateRandomCode();
                          sendSms(context, numeroController.text, randomCode);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerificationPage(
                                permisrectoController: permisrectoController,
                                permisversoController: permisversoController,
                                identiteController: identiteController,
                                griseController: griseController,
                                assuranceController: assuranceController,
                                marqueController: marqueController,
                                anneeController: anneeController,
                                couleurController: couleurController,
                                motorisationController: motorisationController,
                                plaqueController: plaqueController,
                                villeController: villeController,
                                wilayaController: wilayaController,
                                dairaController: dairaController,
                                communeController: communeController,
                                nomController: nomController,
                                prenomController: prenomController,
                                numeroController: numeroController,
                                emailController: emailController,
                                dateController: dateController,
                                sexeController: sexeController,
                                passwordController: passwordController,
                                passwordsMatch: passwordsMatch,
                                registerCallback: registerCallback,
                                alertCallback: alertCallback,
                                initialCode: randomCode,
                                sendSms:
                                    sendSms, // Pass sendSms to VerificationPage
                              ),
                            ),
                          );
                        } else {
                          alertCallback(context, "cette matricule existe deja");
                        }
                      } else {
                        alertCallback(context,
                            "Le mot de passe doit contenir au moins 8 caractères.");
                      }
                    } else {
                      alertCallback(context, "ce compte existe deja");
                    }
                  } else {
                    alertCallback(
                        context, "inscription interdite pour les hommes");
                  }
                } else {
                  alertCallback(
                      context, "Les mots de passe ne correspondent pas");
                }
              } else {
                alertCallback(
                    context, "Remplissez tous les champs s'il vous plaît");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFEC6294),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
          SizedBox(
            height: 40.0,
          )
        ],
      ),
    );
  }
}

class VerificationPage extends StatefulWidget {
  final TextEditingController numeroController;
  final String initialCode;
  final Function(BuildContext, String, String) sendSms; // Receive sendSms

  final TextEditingController permisrectoController;
  final TextEditingController permisversoController;
  final TextEditingController identiteController;
  final TextEditingController griseController;
  final TextEditingController assuranceController;

  final TextEditingController marqueController;
  final TextEditingController anneeController;
  final TextEditingController couleurController;
  final TextEditingController motorisationController;
  final TextEditingController plaqueController;
  final TextEditingController villeController;
  final TextEditingController wilayaController;
  final TextEditingController dairaController;
  final TextEditingController communeController;

  final TextEditingController nomController;
  final TextEditingController prenomController;
  final TextEditingController emailController;
  final TextEditingController dateController;
  final TextEditingController sexeController;
  final TextEditingController passwordController;
  final bool passwordsMatch;
  final Function(
      BuildContext,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String) registerCallback;
  final Function alertCallback;

  VerificationPage({
    required this.numeroController,
    required this.initialCode,
    required this.sendSms,
    required this.permisrectoController,
    required this.permisversoController,
    required this.identiteController,
    required this.griseController,
    required this.assuranceController,
    required this.marqueController,
    required this.anneeController,
    required this.couleurController,
    required this.motorisationController,
    required this.plaqueController,
    required this.villeController,
    required this.wilayaController,
    required this.dairaController,
    required this.communeController,
    required this.nomController,
    required this.prenomController,
    required this.emailController,
    required this.dateController,
    required this.sexeController,
    required this.passwordController,
    required this.passwordsMatch,
    required this.registerCallback,
    required this.alertCallback, // Receive sendSms
  });

  @override
  _VerificationPageState createState() => _VerificationPageState(
      permisrectoController,
      permisversoController,
      identiteController,
      griseController,
      assuranceController,
      marqueController,
      anneeController,
      couleurController,
      motorisationController,
      plaqueController,
      villeController,
      wilayaController,
      dairaController,
      communeController,
      nomController,
      prenomController,
      numeroController,
      emailController,
      dateController,
      sexeController,
      passwordController,
      passwordsMatch,
      registerCallback,
      alertCallback);
}

class _VerificationPageState extends State<VerificationPage> {
  late String code;
  int timeLeft = 20;
  Timer? timer;
  TextEditingController codeController = TextEditingController();
  bool isCodeExpiredDialogVisible = false;

  final TextEditingController permisrectoController;
  final TextEditingController permisversoController;
  final TextEditingController identiteController;
  final TextEditingController griseController;
  final TextEditingController assuranceController;

  final TextEditingController marqueController;
  final TextEditingController anneeController;
  final TextEditingController couleurController;
  final TextEditingController motorisationController;
  final TextEditingController plaqueController;
  final TextEditingController villeController;
  final TextEditingController wilayaController;
  final TextEditingController dairaController;
  final TextEditingController communeController;

  final TextEditingController nomController;
  final TextEditingController prenomController;
  final TextEditingController numeroController;
  final TextEditingController emailController;
  final TextEditingController dateController;
  final TextEditingController sexeController;
  final TextEditingController passwordController;
  final bool passwordsMatch;

  final Function(
      BuildContext,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String,
      String) registerCallback;
  final Function alertCallback;
  _VerificationPageState(
    this.permisrectoController,
    this.permisversoController,
    this.identiteController,
    this.griseController,
    this.assuranceController,
    this.marqueController,
    this.anneeController,
    this.couleurController,
    this.motorisationController,
    this.plaqueController,
    this.villeController,
    this.wilayaController,
    this.dairaController,
    this.communeController,
    this.nomController,
    this.prenomController,
    this.numeroController,
    this.emailController,
    this.dateController,
    this.sexeController,
    this.passwordController,
    this.passwordsMatch,
    this.registerCallback,
    this.alertCallback,
  );
  @override
  void initState() {
    super.initState();
    code = widget.initialCode;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void verifyCode(String enteredCode) {
    if (timeLeft <= 0) {
      // Check if the code expired dialog is not already visible
      if (!isCodeExpiredDialogVisible) {
        showDialog(
            context: globalContext!,
            builder: (BuildContext context) {
              isCodeExpiredDialogVisible = true; // Set the flag
              return AlertDialog(
                title: Text("Erreur"),
                content: Text("Le code a expiré. Veuillez renvoyer le code."),
                actions: <Widget>[
                  TextButton(
                    child: Text("Renvoyer le code"),
                    onPressed: () {
                      isCodeExpiredDialogVisible = false; // Reset the flag
                      generateRandomCode(); // Generate a new code
                      widget.sendSms(
                          globalContext!, widget.numeroController.text, code);
                      // Reset the timer
                      timeLeft = 20;
                      startTimer();
                      Navigator.of(context).pop(); // Close the current dialog
                    },
                  ),
                ],
              );
            });
      }
    } else if (enteredCode == code && timeLeft > 0) {
      if (timer != null) {
        timer!.cancel();
      }
      registerCallback(
        context,
        nomController.text,
        prenomController.text,
        numeroController.text,
        emailController.text,
        dateController.text,
        sexeController.text,
        passwordController.text,
        marqueController.text,
        anneeController.text,
        couleurController.text,
        motorisationController.text,
        plaqueController.text,
        villeController.text,
        wilayaController.text,
        dairaController.text,
        communeController.text,
        permisversoController.text,
        permisrectoController.text,
        identiteController.text,
        griseController.text,
        assuranceController.text,
      );
    } else if (enteredCode.isEmpty) {
      showDialog(
          context: globalContext!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Erreur"),
              content: Text("champ vide. Veuillez ressayer."),
            );
          });
    } else {
      showDialog(
          context: globalContext!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Erreur"),
              content:
                  Text("Le code incorrecte ou code experé. Veuillez ressayer."),
            );
          });
    }
  }

  void generateRandomCode() {
    final random = Random();
    code = (1000 + random.nextInt(9000)).toString();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page de vérification")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: codeController,
              decoration: InputDecoration(labelText: "Code de vérification"),
            ),
            ElevatedButton(
              onPressed: () {
                verifyCode(codeController.text);
              },
              child: Text("Vérifier"),
            ),
            Text("Temps restant : $timeLeft secondes"),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page d'accueil")),
      body: Center(
        child: Text("Bienvenue sur la page d'accueil!"),
      ),
    );
  }
}
