import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/home/homecontroller.dart';
import 'package:takeeazy_customer/main.dart';
import 'package:takeeazy_customer/model/meta/metamodel.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/home/locationconfirm.dart';


class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final homeCont = Provider.of<HomeController>(context, listen: false);
    homeCont.getLocationData();
    print("Home Screen");



    return Scaffold(
      body: Consumer<LocationController>(builder: (_, locationCont, child){
        print('rebuilding location');
        if (locationCont.locationStatus == LocationStatus.Failed) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushNamed(context, TERoutes.map);
          });
        }
        if(locationCont.locationStatus==LocationStatus.Fetched){
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            print('Opening Modal Sheet');
            showModalBottomSheet(context: context, isDismissible:false, builder: (_) {
              return ChangeNotifierProvider.value(
                value: homeCont,
                builder: (_, a)=>LocationConfirm(height, width),);
            });
          });
        }
        return Container(child: Center(child: TEText("Random Widget"),));
      },)
    );
  }
}