import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:chat/infrastructure/server/auth_service.dart';

class Oauth extends StatefulWidget {

  @override
  _OauthState createState() => _OauthState();
}

class _OauthState extends State<Oauth> {

  final Map<String, Buttons> _types = {
    'Apple': Buttons.AppleDark,
    'Email': Buttons.Email,
    'Google': Buttons.GoogleDark,
    'Facebook': Buttons.FacebookNew,
    'GitHub': Buttons.GitHub,
    'Linkedin': Buttons.LinkedIn,
    'Pinterest': Buttons.Pinterest,
    'Tumblr': Buttons.Tumblr,
    'Twitter': Buttons.Twitter,
  };

  void _showDialog(BuildContext context, String key) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Continue with ${key}?"),
        actions: [
          SimpleDialogOption(
            child: Text("Yes"),
            onPressed: () => Navigator.pop(context, [true, key]),
          ),
          SimpleDialogOption(
            child: Text("No"),
            onPressed: () => Navigator.pop(context, [false, key]),
          )
        ],
      ),
    ).then((value) {
      if (value[0]) {
        _oauthSingin(value[1]);
      }
    });
  }

  void _oauthSingin(String key) {
    switch (key) {
      case "Google":
        AuthService().signInWithGoogle();
        break;

      default:
        showDialog(
          context: context,
          builder: (builder) => AlertDialog(
            title: Text("Unhandlable Error Occered"),
            content: Text("Plese try other accounts"),
            actions: [
              SimpleDialogOption(
                child: Text("Close"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
        break;
    }
  }

  List<Widget> _cols(BuildContext context) {
    List _children = <Widget>[];

    _types.forEach((key, value) => _children
        .add(SignInButton(value, onPressed: () => _showDialog(context, key))));

    return _children;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _cols(context),
      ),
    );
  }
}
