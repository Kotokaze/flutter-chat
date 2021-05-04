import 'package:flutter/material.dart';
import 'package:chat/front/widgets/header.dart';
import 'package:chat/front/widgets/footer.dart';

class RoomsPage extends StatelessWidget {
  final String title = 'Chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: title),
      body: Text("Chat rooms"),
      bottomNavigationBar: Footer(currentIndex: 1),
    );
  }
}
