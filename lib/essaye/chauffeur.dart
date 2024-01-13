import 'package:flutter/material.dart';

class ReceiverPage extends StatelessWidget {
  final String notification;

  // Constructeur qui prend la notification comme argument
  ReceiverPage({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Receiver Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Notification reçue : $notification'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Retour à la page précédente (SenderPage)
                Navigator.pop(context);
              },
              child: Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}
/*import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class Chauffeurrr extends StatefulWidget {
  @override
  _ChauffeurrrState createState() => _ChauffeurrrState();
}

class _ChauffeurrrState extends State<Chauffeurrr> {
  final channel = IOWebSocketChannel.connect('ws://192.168.1.35:3001');

  String alertMessage = 'No messages yet';
  Completer<void> completer = Completer<void>();

  @override
  void initState() {
    super.initState();
    print('dataaa ,,$channel');

    // Sending a message to the server
    channel.stream.listen(
      (message) {
        print('Received WebSocket message: $message');
        try {
          final data = jsonDecode(message);
          print('Parsed JSON data: $data');

          final driverId = data['driverId'];
          final messageText = data['message'];

          setState(() {
            alertMessage =
                'Driver $driverId received the message: $messageText';
          });
        } catch (e) {
          print('Error decoding JSON message: $e');
        }
      },
      onError: (error) {
        print('Error receiving message: $error');
      },
      onDone: () {
        print('WebSocket connection closed');
      },
    );
  }

  @override
  void dispose() {
    channel.sink.close(status.normalClosure);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Driver App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Alerte du passager :',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                alertMessage,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/