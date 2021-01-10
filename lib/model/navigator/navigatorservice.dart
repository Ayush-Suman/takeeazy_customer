import 'package:flutter/cupertino.dart';

class NavigatorService{
  static GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get rootNavigator => rootNavigatorKey.currentState;

  static GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get homeNavigator => homeNavigatorKey.currentState;

  static GlobalKey<NavigatorState> ordersNavigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get orderNavigator => ordersNavigatorKey.currentState;

  static GlobalKey<NavigatorState> cartNavigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get cartNavigator => cartNavigatorKey.currentState;
}