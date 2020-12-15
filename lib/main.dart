import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/home/homecontroller.dart';
import 'package:takeeazy_customer/model/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/modelconstructor.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/meta/metamodel.dart';
import 'package:takeeazy_customer/screens/home/home.dart';
import 'package:takeeazy_customer/screens/location/locationselect.dart';



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

  static Route<dynamic> generateRoutes(RouteSettings settings){
    switch(settings.name){
      case home:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_)=>HomeController(),
            builder: (_, a)=> Home()));
      case map:
        Position _position = settings.arguments as Position;
        return MaterialPageRoute(
          builder: (_)=>LocationSelect(_position));
      default: return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text("No such route as ${settings.name}"),),));
    }
  }

}
