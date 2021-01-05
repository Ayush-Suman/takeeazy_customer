import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/homecontroller.dart';
import 'package:takeeazy_customer/controller/locationcontroller.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart' as NetworkCalls;
import 'package:takeeazy_customer/model/dialog/dialogmanager.dart';
import 'package:takeeazy_customer/screens/home/home.dart';
import 'package:takeeazy_customer/screens/map/locationselect.dart';
import 'package:takeeazy_customer/screens/order/order.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NetworkCalls.initialise(tokenModifier: (t) => "Bearer $t");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: widget)),
      ),
      title: 'TakeEazy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomSheetTheme:
            BottomSheetThemeData(modalBackgroundColor: Colors.transparent),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Color(0xff3B6E9E),
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
              fontSize: 18.96,
              fontStyle: FontStyle.normal,
            ),
          ),
          iconTheme: IconThemeData(
            color: Color(0xff3B6E9E),
          ),
          color: Colors.white,
          elevation: 0,
        ),
      ),
      initialRoute: TERoutes.order,
      onGenerateRoute: TERoutes.generateRoutes,
    );
  }
}

class TERoutes {
  static const order = '/orders';
  static const home = '/';
  static const map = 'map';
  static final locationController = LocationController();
  static final homeController = HomeController();

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: homeController),
              ChangeNotifierProvider.value(
                  value: homeController.serviceableAreaController)
            ],
            builder: (_, a) => Home(),
          ),
        );

      case map:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider.value(
                value: locationController,
                builder: (_, a) => LocationSelect()));
      case order:
        return MaterialPageRoute(builder: (context) => Order(),);

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text("No such route as ${settings.name}"),
                  ),
                ));
    }
  }
}
