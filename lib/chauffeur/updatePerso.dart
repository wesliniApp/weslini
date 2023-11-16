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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class UpdatePerso extends StatefulWidget {
  @override
  State<UpdatePerso> createState() => _UpdatePersoState();
}

class _UpdatePersoState extends State<UpdatePerso> {
// Function to fetch user data from Express.js backend
  Future<Map<String, dynamic>> fetchUserData() async {
    final response =
        await http.get(Uri.parse('${Utils.baseUrl}/user/persoShow'));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load user data');
    }
  }

  String email = '';
  String phoneNumber = '';
  String? ville;
  String? wilayaShow;
  String? dairaShow;
  String? communeShow;
  @override
  void initState() {
    super.initState();
    // Call the function to fetch user data when the widget is created
    fetchUserData().then((userData) {
      setState(() {
        // Update the state with the retrieved user data
        email = userData['email'];
        phoneNumber = userData['numero_telephone'].toString();
        ville = userData['ville'];
        wilayaShow = userData['wilaya'];
        dairaShow = userData['daira'];
        communeShow = userData['commune'];
      });
    }).catchError((error) {
      // Handle errors, e.g., show an error message to the user
      print('Error fetching user data: $error');
    });
  }

  Future<void> updateProfile(
    BuildContext context,
    String email,
    String password,
    String phoneNumber,
    String city,
    String state,
    String region,
    String district,
  ) async {
    final Uri url = Uri.parse('${Utils.baseUrl}/user/persoUpdate');
    final Map<String, dynamic> requestBody = {
      'email': emailController.text,
      'password': passwordController.text,
      'numero_telephone': numeroController.text,
      'ville': villeController.text,
      'wilaya': wilayaController.text,
      'daira': dairaController.text,
      'commune': communeController.text,
    };

    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      Route route = MaterialPageRoute(builder: (_) => Home());
      Navigator.pushReplacement(context, route);
      showSnackBar(context, 'Profil mis à jour avec succès');
    } else {
      // Gérez l'échec de la mise à jour, affichez une erreur à l'utilisateur.
      showSnackBar(context, 'Erreur lors de la mise à jour du profil');
    }
  }

  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294);
  Color btngreyColor = Color(0xFF8C8C8C);
  Color textColorBlack = Color.fromARGB(255, 46, 46, 46);

  String message = "";
  late String code;
  int timeLeft = 20;
  Timer? timer;
  TextEditingController codeController = TextEditingController();
  bool isCodeExpiredDialogVisible = false;
  TextEditingController numeroController = TextEditingController();

  final String infobipApiKey =
      '0a26c3a74b07315922aa7db0f622c921-386820c9-a2a4-4d95-b330-3ff98461ad84';
  final String senderNumber = 'Wesslini';

  String generateRandomCode() {
    final random = Random();
    final randomCode = (1000 + random.nextInt(9000)).toString();
    return randomCode;
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

  static _UpdatePersoState? _instance; // Store the instance

  _UpdatePersoState() {
    _instance = this; // Set the instance when the state is created
  }

  static BuildContext? getCurrentContext() {
    return _instance?.context; // Use the stored instance to get the context
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
        context: getCurrentContext() ?? context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('SMS envoyé avec succès'),
            content:
                Text('Le SMS a été envoyé avec succès à $recipientNumber.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: TextStyle(color: primaryColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      print('Random Code: $message');
    } else {
      showDialog(
        context: getCurrentContext() ?? context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur lors de l\'envoi du SMS'),
            content:
                Text('Une erreur s\'est produite lors de l\'envoi du SMS.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(
                    navigatorKey.currentContext!,
                  ).pop();
                },
              ),
            ],
          );
        },
      );
    }
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

  bool passwordsMatch = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController villeController = TextEditingController();
  TextEditingController wilayaController = TextEditingController();
  TextEditingController dairaController = TextEditingController();
  TextEditingController communeController = TextEditingController();

  List<String> wilaya = ['alger', 'boumerdes', 'chlef'];
  String? selectedWilaya;

  List<String> daira = ['alger', 'boumerdes', 'chlef'];
  String? selectedDaira;

  List<String> commune = ['alger', 'boumerdes', 'chlef'];
  String? selectedCommune;

  void updateWilaya(String newValue) {
    setState(() {
      wilayaController.text = newValue;
    });
  }

  void updateDaira(String newValue) {
    setState(() {
      dairaController.text = newValue;
    });
  }

  void updateCommune(String newValue) {
    setState(() {
      communeController.text = newValue;
    });
  }

  void pass(String password) {
    setState(() {
      passwordsMatch = password == confirmPasswordController.text;
    });
  }

  void confirmPass(String confirmPassword) {
    setState(() {
      passwordsMatch = confirmPassword == passwordController.text;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Modifier le sinformations personel",
          style: TextStyle(
            fontFamily: 'inter',
            fontSize: screenWidth < 600 ? 16 : 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Text(
              "Modifier mes informations personel",
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
                      hintText: '$phoneNumber',
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
                  hintText: '$email', // Set the email as the hint
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 5.0,
          ),
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
              child: TextField(
                controller: villeController,
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: primaryColor,
                ),
                decoration: InputDecoration(
                  hintText: '$ville',
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
                hint: Text('$wilayaShow'),
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
                hint: Text('$dairaShow'),
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
                hint: Text('$communeShow'),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    if (numeroController.text.isNotEmpty) {
                      final randomCode = generateRandomCode();

                      sendSms(context, numeroController.text, randomCode);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerificationPage(
                            villeController: villeController,
                            wilayaController: wilayaController,
                            dairaController: dairaController,
                            communeController: communeController,
                            numeroController: numeroController,
                            emailController: emailController,
                            passwordController: passwordController,
                            passwordsMatch: passwordsMatch,
                            initialCode: randomCode,
                            registerCallback: updateProfile,
                            alertCallback: showSnackBar,
                            sendSms: sendSms,
                          ),
                        ),
                      );
                    } else {
                      updateProfile(
                        context,
                        numeroController.text,
                        emailController.text,
                        passwordController.text,
                        villeController.text,
                        wilayaController.text,
                        dairaController.text,
                        communeController.text,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEC6294),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text("Confirmer"),
                ),
              ],
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

class VerificationPage extends StatefulWidget {
  final TextEditingController numeroController;
  final String initialCode;
  final Function(BuildContext, String, String) sendSms;
  final TextEditingController villeController;
  final TextEditingController wilayaController;
  final TextEditingController dairaController;
  final TextEditingController communeController;

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool passwordsMatch;
  final Function(
          BuildContext, String, String, String, String, String, String, String)
      registerCallback;
  final Function alertCallback;

  VerificationPage({
    required this.numeroController,
    required this.initialCode,
    required this.sendSms,
    required this.villeController,
    required this.wilayaController,
    required this.dairaController,
    required this.communeController,
    required this.emailController,
    required this.passwordController,
    required this.passwordsMatch,
    required this.registerCallback,
    required this.alertCallback, // Receive sendSms
  });

  @override
  _VerificationPageState createState() => _VerificationPageState(
      villeController,
      wilayaController,
      dairaController,
      communeController,
      numeroController,
      emailController,
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
  Color primaryColor = Color(0xFFEC6294);

  final TextEditingController villeController;
  final TextEditingController wilayaController;
  final TextEditingController dairaController;
  final TextEditingController communeController;

  final TextEditingController numeroController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool passwordsMatch;

  final Function(
          BuildContext, String, String, String, String, String, String, String)
      registerCallback;
  final Function alertCallback;
  _VerificationPageState(
    this.villeController,
    this.wilayaController,
    this.dairaController,
    this.communeController,
    this.numeroController,
    this.emailController,
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
          context: navigatorKey.currentState?.overlay?.context ?? context,
          builder: (BuildContext context) {
            isCodeExpiredDialogVisible = true; // Set the flag
            return AlertDialog(
              title: Text("Erreur"),
              content: Text("Le code a expiré. Veuillez renvoyer le code."),
              actions: <Widget>[
                TextButton(
                  child: Text("Renvoyer le code",
                      style: TextStyle(color: primaryColor)),
                  onPressed: () async {
                    isCodeExpiredDialogVisible = false;
                    Navigator.of(context)
                        .pop(); // Close the current AlertDialog
                    // Reset the flag
                    generateRandomCode(); // Generate a new code
                    await widget.sendSms(
                      context,
                      widget.numeroController.text,
                      code,
                    );
                    // Reset the timer
                    timeLeft = 20;
                    startTimer();
                  },
                ),
              ],
            );
          },
        );
      }
    } else if (enteredCode == code && timeLeft > 0) {
      if (timer != null) {
        timer!.cancel();
      }
      registerCallback(
        context,
        numeroController.text,
        emailController.text,
        passwordController.text,
        villeController.text,
        wilayaController.text,
        dairaController.text,
        communeController.text,
      );
    } else if (enteredCode.isEmpty) {
      showDialog(
        context: navigatorKey.currentState?.overlay?.context ?? context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("champ vide. Veuillez ressayer."),
          );
        },
      );
    } else {
      showDialog(
        context: navigatorKey.currentState?.overlay?.context ?? context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur"),
            content:
                Text("Le code incorrecte ou code experé. Veuillez ressayer."),
          );
        },
      );
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
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryColor,
        title: Text(
          "Page de vérification",
          style: TextStyle(
            fontFamily: 'inter',
            fontSize: screenWidth < 600 ? 16 : 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20.0), // Adjust the margin as needed
              child: TextField(
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: primaryColor,
                ),
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  hintText: 'Code de vérification',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                ),
                controller: codeController,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                verifyCode(codeController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEC6294),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text("Vérifier"),
            ),
            SizedBox(height: 20),
            Text("Temps restant : $timeLeft secondes"),
          ],
        ),
      ),
    );
  }
}
