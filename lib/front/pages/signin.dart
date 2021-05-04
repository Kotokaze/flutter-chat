import 'package:flutter/material.dart';
import 'package:chat/widgets/oauth.dart';

class SignInPage extends StatelessWidget {
  final String title = 'Sign In';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        centerTitle: true,
        backgroundColor: Colors.black87,
        elevation: 0.0,
      ),
      body: Oauth(),
    );
  }
}
