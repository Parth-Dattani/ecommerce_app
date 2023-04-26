import 'package:ecommerce_app/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController>{
  static const pageId = '/ProfileScreen';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Profile Screen "),
      ),
    );
  }

}