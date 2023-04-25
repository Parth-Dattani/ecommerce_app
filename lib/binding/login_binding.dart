import 'package:get/get.dart';

import '../controller/controller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController(), permanent: false);
  }
}