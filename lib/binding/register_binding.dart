import 'package:get/get.dart';

import '../controller/controller.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<RegisterController>(RegisterController(), permanent: false);
  }

}