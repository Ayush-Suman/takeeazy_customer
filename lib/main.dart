import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/homecontroller.dart';
import 'package:takeeazy_customer/controller/locationcontroller.dart';
import 'package:takeeazy_customer/model/base/modelconstructor.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/dialog/dialogmanager.dart';
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
      builder: (context, widget)=> Navigator(
        onGenerateRoute: (settings)=> MaterialPageRoute(builder: (context) => DialogManager(child: widget)),
      ),
      title: 'TakeEazy',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          bottomSheetTheme: BottomSheetThemeData(modalBackgroundColor: Colors.transparent)
      ),
      initialRoute: TERoutes.map,
      onGenerateRoute: TERoutes.generateRoutes,
    );
  }
}

class TERoutes {

  static const home = '/';
  static const map = 'map';
  static final locationController = LocationController();
  static final homeController = HomeController();

  static Route<dynamic> generateRoutes(RouteSettings settings){
    switch(settings.name){
      case home:

        return MaterialPageRoute(
          builder: (_) =>
              MultiProvider(providers: [ChangeNotifierProvider.value(value:homeController
          ),
          ChangeNotifierProvider.value(value: homeController.serviceableAreaController)],
                builder: (_, a)=> Home(),
              ),

        );

      case map:
        return MaterialPageRoute(
          builder: (_)=> ChangeNotifierProvider.value(
              value: locationController,
              builder:(_, a)=> LocationSelect()
          )
        );

      default: return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text("No such route as ${settings.name}"),),));
    }
  }

}
