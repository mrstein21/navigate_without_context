import 'package:flutter/cupertino.dart';

class NavigatorService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> toNamed(String routeName,{Map<String,dynamic>? arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName,arguments: arguments);
  }

  Future<dynamic> toReplacementNamed(String routeName,{Map<String,dynamic>? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName,arguments: arguments);
  }

  Future<dynamic> offAllNamed(String routeName,{Map<String,dynamic>? arguments}) {
    return navigatorKey.currentState!.
    pushNamedAndRemoveUntil(routeName, (route) => false,arguments: arguments);
  }

}