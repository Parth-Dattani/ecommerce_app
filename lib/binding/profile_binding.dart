import 'package:get/get.dart';

import '../controller/controller.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ProfileBinding>(ProfileBinding(),permanent: false);
  }

}