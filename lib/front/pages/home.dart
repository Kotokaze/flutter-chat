import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat/front/widgets/header.dart';
import 'package:chat/front/widgets/user_card.dart';
import 'package:chat/front/widgets/footer.dart';

class HomePage extends StatefulWidget {
  final String _title = 'Home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User _user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: Header(title: widget._title),
      body: Center(child: UserInfoCard(_user)),
      bottomNavigationBar: Footer(),
    );
  }
}
