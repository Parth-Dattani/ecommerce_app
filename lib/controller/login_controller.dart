import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model.dart';
import '../screen/screen.dart';
import '../utils/utils.dart';
import 'controller.dart';

class LoginController extends BaseController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final loginFormKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  UserModel loggedInUser = UserModel();
  RxBool isObscure = true.obs;
  @override
  void onInit() {
    super.onInit();
    validateUserAuth();
  }

  void loginWithValidation() {
    if (loginFormKey.currentState!.validate()) {
      loader.value = true;
      const CircularProgressIndicator();
      signIn(emailController.value.text, passwordController.value.text);
    } else {
      loader.value = false;
    }
  }

  //register time s.p. store data
  void validateUserAuth() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    var obtainedPassword = sharedPreferences.getString('password');
    if (obtainedEmail != null || obtainedPassword != null) {
      loggedInUser.email = obtainedEmail!;
      if (loggedInUser.email != null /*|| loggedinUserPassword != null*/) {
        final loggedinuser = await auth.signInWithEmailAndPassword(
            email: loggedInUser.email.toString(), password: obtainedPassword!);
        if (loggedinuser != null) {
          Get.toNamed(HomeScreen.pageId);
        }
      }
    } else {
      Get.toNamed(LoginScreen.pageId);
    }
  }

  void signIn(String email, String password) async {
    try {
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint("user : $user");

      if (user != null) {
        sharedPreferencesHelper.storePrefData(email, emailController.text);
        sharedPreferencesHelper.storePrefData(password, passwordController.text);
        sharedPreferencesHelper.storeBoolPrefData(Common.strIsLogin, true);
        Get.offAndToNamed(HomeScreen.pageId);
      }
    } on FirebaseAuthException catch (e) {
      Common.errorSnackBar("error", "somethingWentWrong");
      debugPrint("Something Wrong $e");
    }
  }


  sendDataFirestore(String userName, String email, /*String rool*/) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    UserModel userModel = UserModel();
    userModel.userName = userName;
    userModel.email = email;
    userModel.uid = user!.uid;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
  }
}
