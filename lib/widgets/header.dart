import 'package:flutter/material.dart';

class Header extends StatefulWidget with PreferredSizeWidget {
  Header({Key key, this.title});
  final title;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.settings),  // TODO: 設定への遷移実装
        // child: IconButton(icon: Icon(Icons.settings), onPressed: ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.add),  // TODO: 遷移実装
          // child: IconButton(icon: Icon(Icons.add), onPressed: ),
        ),
      ],
      title: Text(widget.title),
      centerTitle: true,
      backgroundColor: Colors.black87,
      elevation: 0.0,
    );
  }
}
