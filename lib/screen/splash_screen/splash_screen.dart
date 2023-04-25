import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/constant.dart';
import '../../controller/controller.dart';

class SplashScreen extends GetView<SplashController> {
  static const pageId = "/Splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Image.asset(ImagePath.appLogo, scale: 1,),
                const SizedBox(height: 10,),
                Text("welcome To Ecommerce App",style:  CustomTextStyle.buttonText)
              ],
            ),
      ),)
    );
  }
}
