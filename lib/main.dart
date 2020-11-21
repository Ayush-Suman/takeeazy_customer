import 'package:flutter/material.dart';
import 'package:takeeazy_customer/screens/home.dart';

void main() async{

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TakeEazy',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: Home(),
    );
  }
}
