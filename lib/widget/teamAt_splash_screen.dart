import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:team_at/helper/constant.dart';

class TeamAtSplashScreen extends StatelessWidget {
 final Widget nextScreen;
  TeamAtSplashScreen({this.nextScreen});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size ;
    return SplashScreenView(
      home: nextScreen,
      duration: 5000,
      imageSize: (size.height * 0.3).toInt(),
      imageSrc: "assets/images/logo.png",
      backgroundColor: kMainColor ,

    );
  }
}
