import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/homecontroller.dart';
import 'package:takeeazy_customer/controller/locationcontroller.dart';
import 'package:takeeazy_customer/controller/mapcontroller.dart';
import 'package:takeeazy_customer/model/base/modelconstructor.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/screens/home/home.dart';
import 'package:takeeazy_customer/screens/map/locationselect.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  networkInit(ClassSelector());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'TakeEazy',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          bottomSheetTheme: BottomSheetThemeData(modalBackgroundColor: Colors.transparent)
      ),
      initialRoute: TERoutes.home,
      onGenerateRoute: TERoutes.generateRoutes,
    );
  }
}

class TERoutes {
  static const home = '/';
  static const map = 'map';
  static final currentLocation =CurrentLocation();
  static final homeController = HomeController(currentLocation);
  static final mapController = MapController();


  static Route<dynamic> generateRoutes(RouteSettings settings){
    switch(settings.name){
      case home:

        return MaterialPageRoute(
          builder: (_) => MultiProvider(
            providers:[
              ChangeNotifierProvider.value(value:homeController,),
              ChangeNotifierProvider.value(value: homeController.locationController)
            ],
            builder: (_, a)=> Home()));
      case map:
        return MaterialPageRoute(
          builder: (_)=>MultiProvider(
            providers:[
              ChangeNotifierProvider.value(value: currentLocation),
              ChangeNotifierProvider.value(value: mapController)
            ],
          builder:(_, a)=> LocationSelect()));
      default: return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text("No such route as ${settings.name}"),),));
    }
  }

}
