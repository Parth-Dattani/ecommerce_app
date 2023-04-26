import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screen/screen.dart';
import '../utils/utils.dart';
import 'base_controller.dart';

class SplashController extends BaseController {

  @override
  void onInit() {
    Timer(const Duration(seconds: 5), checkLogin);
    super.onInit();
  }

  void checkLogin() async {
    debugPrint("hello ${await sharedPreferencesHelper.retrievePrefBoolData(Common.strIsLogin)}");
    switch (
    await sharedPreferencesHelper.retrievePrefBoolData(Common.strIsLogin)) {
      case true:
        return Get.offAndToNamed(HomeScreen.pageId);
      case false:
        return Get.offAndToNamed(LoginScreen.pageId);
    }
  }
}
