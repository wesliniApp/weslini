import 'dart:convert';
import 'package:weslini/backend/utils.dart';
import 'package:http/http.dart' as http;

Future userLogin(String numeroTelephone, String password) async {
  final Uri url = Uri.parse('${Utils.baseUrl}/user/login');
  final Map<String, dynamic> requestBody = {
    'numero_telephone': numeroTelephone,
    'password': password,
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

Future userRegister(
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
  String permisverso,
  String permisrecto,
  String identite,
  String grise,
  String assurance,
) async {
  final Uri url = Uri.parse('${Utils.baseUrl}/user/registerr');
  final Map<String, dynamic> requestBody = {
    'nom': nom,
    'prenom': prenom,
    'numero_telephone': numero,
    'email': email,
    'date': date,
    'sexe': sexe,
    'password': password,
    'marque_vehicule': marque,
    'annee': annee,
    'couleur': couleur,
    'motorisation': motorisation,
    'plaque': plaque,
    'ville': ville,
    'wilaya': wilaya,
    'daira': daira,
    'commune': commune,
    'permisverso': permisverso,
    'permisrecto': permisrecto,
    'identite': identite,
    'grise': grise,
    'assurance': assurance,
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

Future sendRequestPlaque(String plaque) async {
  final Uri url = Uri.parse('${Utils.baseUrl}/user/testPlaque');
  final Map<String, dynamic> requestBody = {
    'plaque': plaque,
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
