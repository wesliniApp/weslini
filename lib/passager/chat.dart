import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isUser;
  final String avatarImage;

  Message({
    required this.text,
    required this.isUser,
    this.avatarImage = 'assets/logoW.png', // Add the avatar image URL here
  });
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> _messages = [];
  int agentResponseCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEC6294),
        title: Text(
          "Discussion directe",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: message.isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: <Widget>[
                      if (!message.isUser)
                        CircleAvatar(
                          backgroundColor: Color(0xFFFBEDF2),
                          backgroundImage: AssetImage(message.avatarImage),
                        ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          color: message.isUser
                              ? Colors.grey[300]
                              : Color(0xFFFBEDF2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          message.text,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Tapez votre réponse...',
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEC6294)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEC6294)),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    setState(() {
      final userMessage = _textController.text;
      _textController.clear();

      // Add user's message
      _messages.add(Message(text: userMessage, isUser: true));
      agentResponseCount++;

      // Add agent's response
      if (agentResponseCount == 1) {
        _messages.add(Message(
          text: 'Bonjour',
          isUser: false,
          avatarImage: 'logoW.png', // Replace with the actual avatar image URL
        ));
      } else if (agentResponseCount == 2) {
        _messages.add(Message(
          text: "D'accord, on va vous trouver un agent pour répondre.",
          isUser: false,
          avatarImage: 'logoW.png', // Replace with the actual avatar image URL
        ));
      }

      // No agent response for subsequent user messages.
    });
  }
}
