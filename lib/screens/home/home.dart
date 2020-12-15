import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/home/homecontroller.dart';
import 'package:takeeazy_customer/main.dart';

import 'package:takeeazy_customer/screens/home/locationconfirm.dart';


class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final homeCont = Provider.of<HomeController>(context, listen: false);
    homeCont.getLocationData();
    print("Home Screen");
    if (homeCont.locationStatus == LocationStatus.Failed) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushNamed(context, TERoutes.map);
      });
    }

    void _showBottom() {
      showModalBottomSheet(context: context, isDismissible:false, builder: (_) {
        return ChangeNotifierProvider.value(value: homeCont, builder: (_, a)=>LocationConfirm(height, width),);
      });
    }

    return Scaffold();
  }

  var oldWidget = Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Consumer<HomeController>(
              builder: (_, homeCont, child) {WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                if(homeCont.locationStatus==LocationStatus.Fetched){
                  // _showBottom();
                }
              });
              return Text(homeCont.city ?? 'Fetching...');
              })
      )
  );


}