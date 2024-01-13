import 'package:flutter/material.dart';
import 'package:weslini/admin_web/admin.dart';
import 'package:weslini/essaye/chauffeur.dart';
import 'passager.dart'; // Importer le fichier de la page de réception

class SenderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sender Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigation vers la page de réception en passant la notification en tant qu'argument
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReceiverPage(
                    notification: 'Notification depuis Sender Page'),
              ),
            );
          },
          child: Text('Envoyer Notification'),
        ),
      ),
    );
  }
}
/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;
import 'package:weslini/backend/utils.dart';

class Passager extends StatefulWidget {
  @override
  _PassagerState createState() => _PassagerState();
}

class _PassagerState extends State<Passager> {
  final channel = IOWebSocketChannel.connect('ws://192.168.1.35:3001');

  Future<void> sendRequest() async {
    final url = Uri.parse(
        '${Utils.baseUrl}/user/sendRequest'); // Replace with your actual server base URL

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'driverId': 9,
        }),
      );

      if (response.statusCode == 200) {
        // Request successful
        print('Ride request sent successfully');
      } else {
        // Handle other status codes or errors
        print(
            'Failed to send ride request. ${jsonDecode(response.body)['message']}');
      }
    } catch (e) {
      // Handle network or server errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passenger App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            sendRequest();
          },
          child: Text('Envoyer une alerte au chauffeur'),
        ),
      ),
    );
  }

  void sendAlert() {
    // Create a Map representing the JSON message
    final message = {'passengerId': 2, 'type': 'alert'};

    // Convert the Map to a JSON string
    final jsonString = jsonEncode(message);
    print('jsonString, $jsonString');

    // Send the JSON string to the WebSocket server
    channel.sink.add(jsonString);

    // Listen for the close event of the WebSocket connection
    channel.stream.listen(
      (message) {},
      onError: (error) {
        // Handle any errors that occur during the sending process
        print('Error sending message: $error');
      },
      onDone: () {
        // This block is executed when the WebSocket connection is closed
        print(
            'WebSocket connection closed, message sent successfully: $message');
      },
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}*/
