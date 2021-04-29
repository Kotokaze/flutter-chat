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
      body: Oauth(),
    );
  }
}
