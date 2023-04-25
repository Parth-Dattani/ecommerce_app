import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/constant.dart';
import '../../controller/controller.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class RegisterScreen extends GetView<RegisterController> {
  static const pageId = '/RegisterScreen';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:  CommonAppBar(
          title: "Register",
          leadingIcon: ImagePath.arrowBack,
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
            key: controller.registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Please Register Your self",
                  style: CustomTextStyle.headingText,
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonTextField(
                  controller: controller.nameController,
                  validator: Validator.isName,
                  prefixIcon: const Icon(Icons.person),
                  prefixIconColor: ColorConfig.colorBlack,
                  hintText: 'UserName',
                  borderRadius: 10,
                ),
                const SizedBox(
                  height: 20,
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
                  height: 20,
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
                const SizedBox(
                  height: 20,
                ),
                CommonTextField(
                  controller: controller.confirmPasswordController,
                  isObscure: controller.isObscure2.value,
                  validator: Validator.isConfirmPassword,
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: ColorConfig.colorBlack,
                  hintText: 'enter confirm password',
                  borderRadius: 10,
                  suffixIcon: IconButton(
                      icon: Icon(controller.isObscure2.value
                          ? Icons.visibility_off
                          : Icons.visibility, color: controller.isObscure2.value?Colors.black26:Colors.blue),
                      onPressed: () {
                        controller.isObscure2.value =
                        !controller.isObscure2.value;
                      }),
                ),


                const SizedBox(height: 15,),
                CommonButton(
                  onPressed: ()async{
                    await controller.registerWithValidation();
                  },
                  color: ColorConfig.colorPrimary,
                  height: 40,
                  child:  Text("Register", style: CustomTextStyle.buttonText,),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const[
                      Text("already have an account? ", style: TextStyle(color: ColorConfig.colorBlack,fontSize: 15),),
                      Text("Login", style: TextStyle(fontSize: 18, color: ColorConfig.colorLightBlue),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
