
import 'dart:async';
import 'package:get/get.dart';
import 'package:news_app/Res/Routes/routes_names.dart';

class SplashServices{

  void splashTimer(){
    Timer(const Duration(milliseconds: 3000), () {
      Get.toNamed(RouteNames.homeScreen);
    });
  }

}