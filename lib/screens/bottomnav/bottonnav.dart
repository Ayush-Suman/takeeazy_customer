import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/cartcontroller.dart';
import 'package:takeeazy_customer/controller/homecontroller.dart';
import 'package:takeeazy_customer/controller/itemscontroller.dart';
import 'package:takeeazy_customer/controller/nearbystorescontroller.dart';
import 'package:takeeazy_customer/controller/ordersController.dart';
import 'package:takeeazy_customer/controller/shopController.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/screens/cart/cart.dart';
import 'package:takeeazy_customer/screens/nearbystores//nearbystores.dart';
import 'package:takeeazy_customer/screens/home/home.dart';
import 'package:takeeazy_customer/screens/item/item.dart';
import 'package:takeeazy_customer/screens/orders/orders.dart';
import 'package:takeeazy_customer/screens/shop/shop.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';

class BottomNav extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _BottomNavState();
}

class _BottomNavState extends State{
  final GlobalKey globalKey = GlobalKey();
  int _currentIndex = 1;

  List<Widget> widgets = [
    Container(child: Center(child: CircularProgressIndicator(),),),
    HomeNavigator(),
    CartNavigator(),
  ];
  Map<int, GlobalKey<NavigatorState>> navigatorMap = {
    1: NavigatorService.homeNavigatorKey,
    0: NavigatorService.ordersNavigatorKey,
    2: NavigatorService.cartNavigatorKey
  };




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async=>!await navigatorMap[_currentIndex].currentState.maybePop(),
        child: Scaffold(
      key:globalKey,
      body: widgets[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i){
          if(_currentIndex!=i){
          setState(() {
            _currentIndex = i;
            if(i==1){
              HomeNavigator.currentPageIndex++;
            }
          });
        }},
        items:[
          BottomNavigationBarItem(
              icon: Icon(Icons.shop, color: TakeEazyColors.gradient2Color),
              label: "Orders"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: TakeEazyColors.gradient2Color),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon:Icon(Icons.shopping_cart, color: TakeEazyColors.gradient2Color),
              label: "Cart"
          )
        ]
      ),
    ));
  }
}


class HomeNavigator extends StatelessWidget{


  static const String home = '/';
  static const String stores = '/stores';
  static const String shop = '/stores/shop';
  static const String items = '/items';

  static final HomeController homeController = HomeController();
  static final NearbyStoresController nearbyStoresController = NearbyStoresController();
  static final ShopController shopController = ShopController();
  static final ItemsController itemsController = ItemsController();

  static int currentPageIndex = 0;
  static List<String> pageStack = [home, stores, shop, items];

  @override
  Widget build(BuildContext context) {
    print("Rebuilding Home homeNavigator");
    print(currentPageIndex);
    return Navigator(
      key: NavigatorService.homeNavigatorKey,
      initialRoute: pageStack[currentPageIndex],
      onGenerateRoute: generateRoutes,
    );
  }



  static Route<dynamic> generateRoutes(RouteSettings settings){
    print("generating route");
    switch(settings.name){
      case home:
        print('generating new Home');
        return MaterialPageRoute(builder: (_)=>Provider.value(
          value:homeController,
          builder: (_, a) => Home(),
        ),);
        break;
      case stores:
        return MaterialPageRoute(builder: (_)=> Provider.value(
            value:nearbyStoresController,
            builder: (_,a)=> NearbyStores()));
        break;
      case shop:
        return MaterialPageRoute(builder: (_)=> Provider.value(
            value: shopController,
            builder: (_,a) => Shop()));
        break;
      case items:
        return MaterialPageRoute(builder: (_)=>Provider.value(
            value: itemsController,
            builder:(_,a)=>Item()));
        break;
    }
  }


}


class CartNavigator extends StatelessWidget{
  static const String cart = '/';

  static const String orders = '/orders';

  static final OrdersController ordersController = OrdersController();

  static final CartController cartController = CartController();

  static String currentPage = cart;

  @override
  Widget build(BuildContext context) {
    print(currentPage);
    return Navigator(
      key: NavigatorService.cartNavigatorKey,
      initialRoute: currentPage,
      onGenerateRoute: generateRoutes,
    );
  }


  static Route<dynamic> generateRoutes(RouteSettings settings){
    print("generating route");
    switch(settings.name){
      case cart:
        currentPage = cart;
        return MaterialPageRoute(builder: (_)=>Provider.value(
          value: cartController,
          builder: (_, a)=> Cart()
        ));
        break;
      case orders:
        currentPage = orders;
        return MaterialPageRoute(
          builder: (_) => Provider.value(
            value: ordersController,
            builder: (_, a) => Orders(),
          ),
        );
        break;
    }
  }
}