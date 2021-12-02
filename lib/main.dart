import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pixelthat/screens/pages/first.dart';
import 'screens/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Retro'),
        debugShowCheckedModeBanner: false,
        home: FirstScreen());
  }
}
