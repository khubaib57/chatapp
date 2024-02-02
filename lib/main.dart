import 'package:flutter/material.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatefulWidget {
  const ChatApp({Key? key});

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  TextEditingController messageController = TextEditingController();
  List<Message> messages = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 176, 39, 94),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
        ),
        //appbar

        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return MessageBubble(message: messages[index]);
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: 250,
                  height: 60,
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      setState(() {
                        messages.add(
                          Message(text: messageController.text, isSent: true),
                        );
                        messageController.clear();
                      });
                    }
                  },
                  icon: Icon(Icons.send),
                ),
                IconButton(
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      setState(() {
                        messages.add(
                          Message(text: messageController.text, isSent: false),
                        );
                        messageController.clear();
                      });
                    }
                  },
                  icon: Icon(Icons.arrow_circle_down),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final bool isSent;

  Message({required this.text, required this.isSent});
}

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      alignment: message.isSent ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: message.isSent ? Color.fromARGB(255, 163, 191, 205) : Color.fromARGB(255, 227, 142, 176),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(message.text),
      ),
    );
  }
}
