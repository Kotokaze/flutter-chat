import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  final _footerItemNames = ["Home", "Chat", "Timeline", "News", "Wallet"];
  final _footerIcons = [
    Icons.home,
    Icons.textsms,
    Icons.access_time,
    Icons.content_paste,
    Icons.work
  ];

  int _currentIndex = 0;
  List<BottomNavigationBarItem> _bottomNavigationBarItems = [];

  @override
  void initState() {
    super.initState();
    _updateActiveState(_currentIndex);
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
            title: Text(_footerItemNames[i], style: TextStyle(color: Colors.black87)),
            // label: _footerItemNames[i],
          ),
        );
      } else {
        _bottomNavigationBarItems.add(
          BottomNavigationBarItem(
            icon: Icon(_footerIcons[i], color: Colors.black26),
            title: Text(_footerItemNames[i], style: TextStyle(color: Colors.black26)),
            // label: _footerItemNames[i],
          ),
        );
      }
    }
  }

  void _onTapped(int index) {
    setState(() {
      _updateActiveState(index);
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      // type: BottomNavigationBarType.shifting,
      items: _bottomNavigationBarItems,
      currentIndex: _currentIndex,
      onTap: _onTapped,
    );
  }
}
