import 'dart:async';
import 'package:get/get.dart';
import 'package:project/View/OnBoardingScreen.dart';

import '../View/AdresseScreen.dart';
import '../View/LoginScreen.dart';


class SplashScreenController extends GetxController{

@override
  void onInit() {
    super.onInit();
    Timer(
        Duration(milliseconds:6000),
        ()=>Get.off(OnBoardingScreen()));

  }
}