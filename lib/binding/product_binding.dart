import 'package:ecommerce_app/controller/controller.dart';
import 'package:get/get.dart';

class ProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ProductController>(ProductController(), permanent: false);
  }

}