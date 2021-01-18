import 'package:flutter/cupertino.dart';

class NavigatorService{
  static GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get rootNavigator => rootNavigatorKey.currentState;
  static Map<String, dynamic>  rootArgument = {};

  static GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get homeNavigator => homeNavigatorKey.currentState;
  static Map<String, dynamic> homeArgument = {};

  static GlobalKey<NavigatorState> ordersNavigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get orderNavigator => ordersNavigatorKey.currentState;
  static Map<String, dynamic> orderArgument = {};

  static GlobalKey<NavigatorState> cartNavigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get cartNavigator => cartNavigatorKey.currentState;
  static Map<String, dynamic> cartArgument = {};
}