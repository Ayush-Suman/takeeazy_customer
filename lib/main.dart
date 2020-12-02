import 'package:flutter/material.dart';
import 'package:takeeazy_customer/model/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/meta/metamodel.dart';
import 'package:takeeazy_customer/model/stores/storesModel.dart';
import 'package:takeeazy_customer/screens/home.dart';


void main() async{
  networkInit();
  request<MetaModel>(getMeta, call: CALLTYPE.GET, auth: false, param: {'geo':'29.0000,77.700000'}).then((value) {print((value as MetaModel).city.cityName);});
  request<MetaModel>(getMeta, call: CALLTYPE.GET, auth: false, param: {'geo':'29.0000,77.700000'}).then((value) {print((value as MetaModel).city.cityName);});
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
