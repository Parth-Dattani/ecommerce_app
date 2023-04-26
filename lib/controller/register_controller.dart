import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';
import '../screen/screen.dart';
import 'controller.dart';

class RegisterController extends BaseController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();

  RxBool isObscure = true.obs;
  RxBool isObscure2 = true.obs;

  var currentItemSelected = "user".obs;
  final auth = FirebaseAuth.instance;

  get user => auth.currentUser;

  Future<void> registerWithValidation() async {
    if (registerFormKey.currentState!.validate()) {
      loader.value = true;
      //signUp(email: emailController.value.text, password: passwordController.value.text, userName: nameController.value.text,rool: currentItemSelected.value );
      signUp(nameController.value.text, emailController.value.text,
          passwordController.value.text,/* currentItemSelected.value*/);
      loader.value = false;
    }
  }

  void signUp(String userName, String email, String password) async {
    loader.value = true;
    const CircularProgressIndicator();
    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
          //String? registerToken = await FirebaseMessaging.instance.getToken();

      //print("GEt TOKEN $registerToken");
      sendDataFirestore(userName, email);
    }).catchError((e) {});

    if (user != null) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(
        'email',
        email,
      );
      sharedPreferences.setString('password', password);
      Get.offAndToNamed(HomeScreen.pageId);
    }

    loader.value = false;
  }

  //user store in firestore
  sendDataFirestore(
      String userName, String email,) async {
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
