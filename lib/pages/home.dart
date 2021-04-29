import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat/widgets/header.dart';
import 'package:chat/widgets/footer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: Header(),
      body: Center(child: Text("${user}")),
      bottomNavigationBar: Footer(),
    );
  }
}
