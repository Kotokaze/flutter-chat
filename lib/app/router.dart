import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:chat/front/pages/signin.dart';
import 'package:chat/front/pages/home.dart';
import 'package:chat/front/pages/rooms.dart';

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
          child: RoomsPage(),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;
      default:
        return null;
    }
  }
}
