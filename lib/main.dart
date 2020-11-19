import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ragaviz/screens/WelcomePage.dart';

void main() {
  runApp(MyApp());
} // It runs the app form class MyApp.

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Curing Ragas ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  } // It builds the app with title, theme, home.
}
