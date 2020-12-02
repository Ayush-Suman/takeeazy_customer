import 'package:flutter/material.dart';
import 'package:takeeazy_customer/model/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/modelconstructor.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/meta/metamodel.dart';
import 'package:takeeazy_customer/screens/home.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  networkInit(ClassSelector());

  request<MetaModel>(getMeta, call: CALLTYPE.GET);
  //print(meta.city.cityName);
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
