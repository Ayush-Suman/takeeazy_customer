import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/homecontroller.dart';
import 'package:takeeazy_customer/controller/locationcontroller.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart' as NetworkCalls;
import 'package:takeeazy_customer/model/dialog/dialogmanager.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/screens/category/category.dart';
import 'package:takeeazy_customer/screens/home/home.dart';
import 'package:takeeazy_customer/screens/map/locationselect.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NetworkCalls.initialise(tokenModifier: (t)=>"Bearer $t");
  runApp(MyApp());
}






class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: NavigatorService.rootNavigatorKey,
      builder: (context, widget)=> Navigator(
        onGenerateRoute: (settings)=> MaterialPageRoute(builder: (context) => DialogManager(child: widget)),
      ),
      title: 'TakeEazy',
      theme: ThemeData(
        accentColor: TakeEazyColors.gradient2Color,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(
              color: TakeEazyColors.gradient2Color,
            ),
            elevation: 0,
            textTheme: TextTheme(
              headline6: TextStyle(
                color: Color(0xff3b6e9e),
                fontSize: 18.96,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          bottomSheetTheme: BottomSheetThemeData(modalBackgroundColor: Colors.transparent)
      ),
      home: Category(),
      //initialRoute: TERoutes.map,
      //onGenerateRoute: TERoutes.generateRoutes,
    );
  }
}

class TERoutes {
  static const home = '/';
  static const map = 'map';

  static final homeController = HomeController();
  static final locationController = LocationController();


  static Route<dynamic> generateRoutes(RouteSettings settings){
    switch(settings.name){
      case home:
        return MaterialPageRoute(
          builder: (_) =>
              Provider.value(value:homeController,
                builder: (_, a) => Home(),
              ),

        );

      case map:
        return MaterialPageRoute(
          builder: (_)=>
              Provider.value(
                  value: locationController,
                  builder:(_, a)=> LocationSelect()
              )
        );

      default: return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text("No such route as ${settings.name}"),),));
    }
  }

}
