import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:chat/pages/signin.dart';
import 'package:chat/pages/home.dart';
import 'package:chat/pages/rooms.dart';

mixin PageRouter implements StatelessWidget {
  static Route generate(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return PageTransition(
          child: SignInPage(),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;
      case '/home':
        return PageTransition(
          child: HomePage(),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;
      case '/rooms':
        return PageTransition(
          child: Rooms(),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;
      default:
        return null;
    }
  }
}
