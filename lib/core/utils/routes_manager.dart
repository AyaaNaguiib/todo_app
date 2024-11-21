import 'package:flutter/material.dart';
import 'package:todo_app/presentaion/screens/home_screen/home_screen.dart';

import '../../presentaion/screens/auth/login/login.dart';
import '../../presentaion/screens/auth/register/register.dart';
import '../../presentaion/screens/splash_screen/splash_screen.dart';

class RoutesManager{
  static const String splashRoute = '/splash';
  static const String registerRoute = '/register';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';


  static Map<String, WidgetBuilder> routes = {
    RoutesManager.splashRoute: (_) => SplashScreen(),
    RoutesManager.homeRoute: (_) => HomeScreen(),
  };

static Route ? router(RouteSettings settings){
  switch(settings.name){
    case homeRoute:
      return MaterialPageRoute(
          builder: (context)=> HomeScreen());
    case registerRoute:
      return MaterialPageRoute(
          builder: (context)=> Register());
    case loginRoute:
      return MaterialPageRoute(
          builder: (context)=> Login());
  }
}
}