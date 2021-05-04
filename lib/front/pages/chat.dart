import 'package:flutter/material.dart';


class ChatPage extends StatelessWidget {
  ChatPage(this.title);
  final title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Text("Chat Rooms"),
    );
  }
}
