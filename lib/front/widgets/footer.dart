import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  Footer({Key key, this.currentIndex = 0});
  int currentIndex;

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  final _footerItemNames = [
    "Home",
    "Chat",
    // "Timeline",
    // "News",
    // "Wallet",
  ];
  final _footerIcons = [
    Icons.home,
    Icons.textsms,
    // Icons.access_time,
    // Icons.content_paste,
    // Icons.work
  ];

  List<BottomNavigationBarItem> _bottomNavigationBarItems = [];

  @override
  void initState() {
    super.initState();
    _updateActiveState(widget.currentIndex);
  }

  void _updateActiveState(int index) {
    if (_bottomNavigationBarItems.isNotEmpty) {
      _bottomNavigationBarItems.clear();
    }

    for (var i = 0; i < _footerItemNames.length; i++) {
      if (i == index) {
        _bottomNavigationBarItems.add(
          BottomNavigationBarItem(
            icon: Icon(_footerIcons[i], color: Colors.black87),
            title: Text(_footerItemNames[i],
                style: TextStyle(color: Colors.black87)),
          ),
        );
      } else {
        _bottomNavigationBarItems.add(
          BottomNavigationBarItem(
            icon: Icon(_footerIcons[i], color: Colors.black26),
            title: Text(_footerItemNames[i],
                style: TextStyle(color: Colors.black26)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    void _onTapped(int index) async {
      setState(() {
        _updateActiveState(index);
        widget.currentIndex = index;
      });

      switch (widget.currentIndex) {
        case 0:
          await Navigator.pushNamed(context, '/home');
          break;
        case 1:
          await Navigator.pushNamed(context, '/rooms');
          break;
        default:
          break;
      }
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: _bottomNavigationBarItems,
      currentIndex: widget.currentIndex,
      onTap: _onTapped,
    );
  }
}
