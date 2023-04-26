import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';

class Common {
  static const String strIsLogin = 'is_login';
  static const String strToken = 'str_token';

  static void errorSnackBar(String error, String somethingWentWrong) {
    Get.snackbar(
      error, somethingWentWrong,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorConfig.colorDarkBlue,
      colorText: ColorConfig.colorWhite,
      forwardAnimationCurve: Curves.easeOutBack,
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.all(15),
      // icon: const Icon(Icons.close, color: ColorsConfig.colorWhite)
    );
  }

}
