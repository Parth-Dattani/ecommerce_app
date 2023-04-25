import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../constant/constant.dart';
import '../../controller/controller.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../screen.dart';

class LoginScreen extends GetView<LoginController> {
  static const pageId = '/loginScreen';

  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        backgroundColor: ColorConfig.colorLightGrey,
        resizeToAvoidBottomInset: false,
        appBar: const CommonAppBar(
          title: "Login ",
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: ColorConfig.colorBlurRadius,
            boxShadow: const[
              BoxShadow(
                blurRadius: 20
              )
            ]
          ),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  "Please Verify Your Account",
                  style: CustomTextStyle.headingText,
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonTextField(
                  controller: controller.emailController,
                  validator: Validator.isEmail,
                  prefixIcon: const Icon(Icons.email_rounded),
                  prefixIconColor: ColorConfig.colorBlack,
                  hintText: 'enter email',
                  borderRadius: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonTextField(
                  controller: controller.passwordController,
                  isObscure: controller.isObscure.value,
                  validator: Validator.isPassword,
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: ColorConfig.colorBlack,
                  hintText: 'enter password',
                  borderRadius: 10,
                  suffixIcon: IconButton(
                      icon: Icon(controller.isObscure.value
                          ? Icons.visibility_off
                          : Icons.visibility, color: controller.isObscure.value?Colors.black26:Colors.blue),
                      onPressed: () {
                        controller.isObscure.value =
                        !controller.isObscure.value;
                      }),
                ),

                const SizedBox(height: 1),
                TextButton(
                  onPressed: () {
                    // Get.toNamed(ForgotPasswordScreen.pageId, arguments: {
                    //   "isForgot": controller.isForgot.value = true,
                    //   "isPhone": controller.isPhone.value = false,
                    // });
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Forgot Password",
                      style: CustomTextStyle.linkText,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CommonButton(
                  onPressed: (){
                    controller.loginWithValidation();
                  },
                  color: ColorConfig.colorPrimary,
                  height: 40,
                  child:  Text("Login", style: CustomTextStyle.buttonText,),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                    onPressed: () {
                      Get.toNamed(RegisterScreen.pageId);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Don't have a account? ",
                          style: TextStyle(
                              color: ColorConfig.colorBlack, fontSize: 15),
                        ),
                        Text(
                          "Register",
                          style: TextStyle(
                              color: ColorConfig.colorLightBlue, fontSize: 18),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: Get.width * 0.32, height: 1, color: ColorConfig.colorPrimary),
                    const Spacer(),
                    const Text(
                      "Sign in With",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Container(
                      width: Get.width * 0.32,
                      height: 1,
                      color: ColorConfig.colorPrimary,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonButton(
                      color: Colors.black,
                      height: 55,
                      width: 10,
                      onPressed: () {
                        Common.errorSnackBar("opps!", 'This Feature is Under Development');
                      },
                      child: const Icon(
                        Icons.phone_iphone,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CommonButton(
                      color: Colors.black,
                      height: 55,
                      width: 10,
                      onPressed: () async {
                        Common.errorSnackBar("opps!", 'This Feature is Under Development');
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.google,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CommonButton(
                      color: Colors.black,
                      height: 55,
                      width: 10,
                      onPressed: () async {
                        Common.errorSnackBar("opps!", 'This Feature is Under Development');
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.facebook,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
