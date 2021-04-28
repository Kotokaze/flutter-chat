import 'package:flutter/material.dart';
import 'package:chat/widgets/oauth.dart';

/// Entrypoint for various sign-in flows with Firebase.
class SignInPage extends StatelessWidget {
  /// The page title.
  final String title = 'Sign In';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Builder(builder: (BuildContext context) {
        return ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            // UserInfoCard(user),
            Oauth(),
          ],
        );
      }),
    );
  }
}
