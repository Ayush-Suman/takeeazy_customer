import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/homecontroller.dart';
import 'package:takeeazy_customer/controller/shopController.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/screens/cart/cart.dart';
import 'package:takeeazy_customer/screens/category/category.dart';
import 'package:takeeazy_customer/screens/home/home.dart';
import 'package:takeeazy_customer/screens/item/item.dart';
import 'package:takeeazy_customer/screens/shop/shop.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';

class BottomNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomNavState();
}

class _BottomNavState extends State {
  final GlobalKey globalKey = GlobalKey();
  int _currentIndex = 1;

  List<Widget> widgets = [
    Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ),
    HomeNavigator(),
    Cart(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: widgets[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) {
            setState(() {
              _currentIndex = i;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.shop, color: TakeEazyColors.gradient2Color),
                label: "Orders"),
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: TakeEazyColors.gradient2Color),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart,
                    color: TakeEazyColors.gradient2Color),
                label: "Cart")
          ]),
    );
  }
}

class HomeNavigator extends StatelessWidget {
  static const String home = '/';
  static const String stores = '/stores';
  static const String shop = '/stores/shop';
  static const String items = '/items';

  static final HomeController homeController = HomeController();
  static final ShopController shopController = ShopController();

  static String currentPage = home;

  @override
  Widget build(BuildContext context) {
    print("Rebuilding Home homeNavigator");
    print(currentPage);
    return Navigator(
      key: NavigatorService.homeNavigatorKey,
      initialRoute: currentPage,
      onGenerateRoute: generateRoutes,
    );
  }

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    print("generating route");
    switch (settings.name) {
      case home:
        print('generating new Home');
        currentPage = home;
        return MaterialPageRoute(
          builder: (_) => Provider.value(
            value: homeController,
            builder: (_, a) => Home(),
          ),
        );
        break;
      case stores:
        currentPage = stores;
        return MaterialPageRoute(builder: (_) => Category());
        break;
      case shop:
        currentPage = shop;
        return MaterialPageRoute(
          builder: (_) => Provider.value(
            value: shopController,
            builder: (context, child) => Shop(),
          ),
        );
        break;
      case items:
        currentPage = items;
        return MaterialPageRoute(builder: (_) => Item());
        break;
    }
  }
}
