import 'package:flutter/cupertino.dart';

class NavigatorService{
  static GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get rootNavigator => rootNavigatorKey.currentState;

}