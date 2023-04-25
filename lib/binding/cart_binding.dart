import 'package:get/get.dart';

import '../controller/controller.dart';

class CartBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<CartController>(CartController(),permanent: false);
  }

}