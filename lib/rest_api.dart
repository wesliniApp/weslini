import 'dart:convert';
import 'package:weslini/utils.dart';
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
