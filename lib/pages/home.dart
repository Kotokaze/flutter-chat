import 'package:flutter/material.dart';
import 'package:chat/widgets/header.dart';
import 'package:chat/widgets/footer.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Center(child: Text("Welcome")),
      bottomNavigationBar: Footer(),
    );
  }
}
