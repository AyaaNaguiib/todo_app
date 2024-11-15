import 'package:flutter/material.dart';

import '../../../core/utils/date_Extension/assets_manager.dart';
import '../../../core/utils/routes_manager.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, RoutesManager.homeRoute);
    },
    );
    return Container(
      child: Image.asset(AssetsManager.lightSplash, fit:BoxFit.fill),
    );
  }
}
