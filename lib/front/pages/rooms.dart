import 'package:flutter/material.dart';
import 'package:chat/widgets/header.dart';
import 'package:chat/widgets/footer.dart';

class Rooms extends StatefulWidget {
  final String title = 'Chat';

  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: widget.title),
      body: Text("Chat rooms"),
      bottomNavigationBar: Footer(currentIndex: 1),
    );
  }
}
