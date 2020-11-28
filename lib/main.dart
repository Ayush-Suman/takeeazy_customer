import 'package:flutter/material.dart';
import 'package:takeeazy_customer/model/base/URLRoutes.dart' as Routes;
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/stores/storesModel.dart';
import 'package:takeeazy_customer/screens/home.dart';


void main() async{
  List<ShopModel> shop = await request<List<ShopModel>>(Routes.getShops, call: CALLTYPE.GET, auth: false, fromJSON: shopModel);
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
