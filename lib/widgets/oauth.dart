import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Oauth extends StatefulWidget {
  @override
  _OauthState createState() => _OauthState();
}

class _OauthState extends State<Oauth> {
  User user;

  @override
  void initState() {
    _auth.userChanges().listen((event) => setState(() => user = event));
    super.initState();
  }

  final Map<String, Buttons> _types = {
    // 'Apple': Buttons.AppleDark,
    // 'Email': Buttons.Email,
    'Google': Buttons.GoogleDark,
    // 'Facebook': Buttons.FacebookNew,
    // 'GitHub': Buttons.GitHub,
    // 'Linkedin': Buttons.LinkedIn,
    // 'Pinterest': Buttons.Pinterest,
    // 'Tumblr': Buttons.Tumblr,
    // 'Twitter': Buttons.Twitter,
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
    ).then((value) async {
      if (value[0]) {
        await _oauthSingin(value[1]);
      }
    });
  }

  _oauthSingin(String key) {
    switch (key) {
      case "Google":
        _signInWithGoogle();
        break;

      default:
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
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _cols(context),
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    try {
      UserCredential userCredential;
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      userCredential = await _auth.signInWithCredential(googleAuthCredential);

      final user = userCredential.user;
      Navigator.pushReplacementNamed(context, '/home', arguments: user);
    } catch (e) {
      print(e);
    }
  }
}
