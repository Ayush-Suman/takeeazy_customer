import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/home/homecontroller.dart';
import 'package:takeeazy_customer/main.dart';

import 'package:takeeazy_customer/screens/home/locationconfirm.dart';


class Home extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeController>(context, listen:  false).getLocationData();
    print("Home Screen");
    return Scaffold(
        body: Stack(
            children:[
              Center(
                  child: Consumer<HomeController>(
                      builder: (_, homeCont, child) =>
                          Text(homeCont.city??'Fetching...')
                  )
              ),
              Consumer<HomeController>(
                  builder: (_, homeCont, child) {
                    if(homeCont.locationStatus == LocationStatus.Failed){
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Navigator.pushNamed(context, TERoutes.map);
                      });
                    }
                      return homeCont.locationStatus==LocationStatus.Fetched?
                      Positioned(child: LocationConfirm(), bottom: 0,):
                      Container();})
            ]
        )
    );
  }
}