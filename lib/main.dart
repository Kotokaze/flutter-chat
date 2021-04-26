import 'package:flutter/material.dart';
import 'package:chat/ui/header.dart';
import 'package:chat/ui/footer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      // theme: ThemeData(primarySwatch: Colors.blue),
      // debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: Header(),
      body: Center(child: Text("Hello")),
      bottomNavigationBar: Footer(),
    );
  }
}
