import 'package:flutter/material.dart';
import 'package:todo_app/presentaion/screens/home_screen/home_screen.dart';

class RoutesManager{
  static const String homeRoute = '/home';

static Route ? router(RouteSettings settings){
  switch(settings.name){
    case homeRoute:
      return MaterialPageRoute(builder: (context)=> HomeScreen());
  }
}
}