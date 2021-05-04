import 'package:flutter/material.dart';
import 'package:chat/widgets/oauth.dart';
import 'package:chat/widgets/header.dart';
import 'package:chat/widgets/user_card.dart';
import 'package:chat/widgets/footer.dart';

class HomePage extends StatefulWidget {
  final String title = 'Home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: widget.title),
      body: Center(child: UserInfoCard(Oauth.user)),
      bottomNavigationBar: Footer(),
    );
  }
}
