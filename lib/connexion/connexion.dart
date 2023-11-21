import 'package:weslini/chauffeur/chauffeurHome.dart';
import 'package:weslini/home.dart';

import 'package:weslini/passager/inscrPassager.dart';
import 'package:weslini/passager/passager1.dart';

import 'package:weslini/connexion/form_fields_widgets.dart';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:math';

BuildContext? globalContext;

class Connexion extends StatefulWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser() async {
    final String numero = _numeroController.text;
    final String password = _passwordController.text;
    final modifiedNumber = numero.replaceFirst('0', '213');

    print('Numero de telephone: $modifiedNumber');
    print('Mot de passe: $password');
    final Map<String, dynamic> userData = {
      "numero_telephone": modifiedNumber,
      "password": password,
    };
    final String apiUrl =
        'http://192.168.1.40:3000/user/login'; // Replace with your API URL

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      // User logged in successfully
      // You can handle the response data here
      final responseData = json.decode(response.body);

      print(responseData);

      final Route route;
      switch (responseData['data']['type']) {
        case 'passager':
          route = MaterialPageRoute(
              builder: (_) => PassagerHome(
                    userType: responseData['data']['type'],
                    userName: responseData['data']['nom'],
                    userPrenom: responseData['data']['prenom'],
                    userEmail: responseData['data']['email'],
                  ));
          break;
        case 'passageretchaufeur':
          route = MaterialPageRoute(
              builder: (_) => PassagerHome(
                    userType: responseData['data']['type'],
                    userName: responseData['data']['nom'],
                    userPrenom: responseData['data']['prenom'],
                    userEmail: responseData['data']['email'],
                  ));
          break;
        case 'chauffeur':
          route = MaterialPageRoute(builder: (_) => ChauffeurHome());
          break;
        default:
          route = MaterialPageRoute(builder: (_) => InscrPassager());
      }

      Navigator.pushReplacement(context, route);
      // Navigate to the next screen or perform other actions
    } else if (response.statusCode == 401) {
      print("no matching info");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("Aucune information correspondante."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // Handle other errors
    }
  }

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
    final url = 'https://api.infobip.com/sms/1/text/single';
    final headers = {
      'Authorization': 'App $infobipApiKey',
      'Content-Type': 'application/json',
    };

    final body = {
      'from': senderNumber,
      'to': recipientNumber,
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

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final url = Uri.parse(
        'http://192.168.1.14:3000/user/verifier-numero?numero_telephone=$phoneNumber');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('u don have an acount');
      } else if (response.statusCode == 400) {
        print('u have an acount');
        globalContext = context;

        final randomCode = generateRandomCode();
        sendSms(context, phoneNumber, randomCode);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationPage(
              phoneController: _numeroController,
              initialCode: randomCode,
              sendSms: sendSms,
            ),
          ),
        );

        // Handle the error response here
      }
    } catch (e) {
      print('Error: $e');
      // Handle network or other errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFFBEDF2),
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
                            data: Icons
                                .lock, // Utilisez Icons.lock pour le champ de mot de passe
                            txtHint: "mot de passe",
                            obsecure:
                                true, // Utilisez 'obscure' au lieu de 'obsecure'
                          ),
                          TextButton(
                            child: Text(
                              'Mot de passe oublié?',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF979797),
                              ),
                            ),
                            onPressed: (_numeroController.text.isNotEmpty)
                                ? () {
                                    String phoneNumber = _numeroController.text;
                                    if (phoneNumber.isNotEmpty) {
                                      verifyPhoneNumber(phoneNumber);
                                    }
                                  }
                                : () {
                                    // Afficher un message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Veuillez saisir votre numéro de téléphone'),
                                      ),
                                    );
                                  },
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
                          loginUser();
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
                          'Connexion',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      child: Text(
                        'Vous n\'avez pas un compte?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF979797),
                        ),
                      ),
                      onPressed: () {
                        // Naviguer vers la page de création de compte

                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => InscrPassager()));
                      },
                    ),
                    SizedBox(
                      height: 80,
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

class VerificationPage extends StatefulWidget {
  final TextEditingController phoneController;
  final String initialCode;
  final Function(BuildContext, String, String) sendSms; // Receive sendSms

  VerificationPage({
    required this.phoneController,
    required this.initialCode,
    required this.sendSms, // Receive sendSms
  });

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late String code;
  int timeLeft = 20;
  Timer? timer;
  TextEditingController codeController = TextEditingController();
  bool isCodeExpiredDialogVisible = false;

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
                          globalContext!, widget.phoneController.text, code);
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
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage(phoneNumber: widget.phoneController.text)));
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
      appBar: AppBar(
          backgroundColor: Color(0xFFEC6294),
          title: Text(
            "Page de vérification",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          )),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 60),
            Text(
                'Un code de vérification a été envoyé à votre numéro de téléphone.'),
            SizedBox(height: 30),
            TextField(
              controller: codeController,
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
                  verifyCode(codeController.text);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFEC6294),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  "Vérifier",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Temps restant : $timeLeft secondes"),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String phoneNumber;

  HomePage({required this.phoneNumber});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _passwordsMatch = true;

  Future<void> changePassword(String newPassword, String phoneNumber) async {
    final Uri url = Uri.parse('http://192.168.1.14:3000/user/changePassword');

    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'newPassword': newPassword,
        'phoneNumber': phoneNumber.replaceFirst('0', '213'),
      }),
    );

    if (response.statusCode == 200) {
      print('Password updated successfully');
      Navigator.push(context, MaterialPageRoute(builder: (_) => Connexion()));
    } else {
      print('Error updating password: ${response.statusCode}');
      // Handle the error and show an appropriate message to the user.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFEC6294),
          title: Text(
            "Modifier mot de passe ",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          )),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 60),
                Text('Modifier votre mot de passe '),
                SizedBox(height: 30),
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
                    hintText: "Mot de passe",
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(
                      color: Color(0xFF979797),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
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
                onPressed: (_passwordsMatch)
                    ? () {
                        String newPassword = _passwordController
                            .text; // Remplacez par le nouveau mot de passe
                        String phoneNumber = widget
                            .phoneNumber; // Remplacez par le numéro de téléphone

                        changePassword(newPassword, phoneNumber);
                      }
                    : null, // Désactiver le bouton si les mots de passe ne correspondent pas
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFEC6294),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Modifier mot de passe ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
