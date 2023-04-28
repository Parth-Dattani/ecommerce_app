import 'dart:convert';
import 'package:ecommerce_app/model/category_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/utils.dart';
import 'controller.dart';

class CartController extends BaseController {
  RxString productName = "".obs;
  RxList cartData = [].obs;
  RxList<CategoryResponse> cartList = <CategoryResponse>[].obs;
  Rx<int> quantity = 0.obs;

  @override
  void onInit() {
    if(Get.arguments != null){
      quantity.value = Get.arguments["quantity"];
    }
    getCartData();
    debugPrint("cart Data: $cartData");
    super.onInit();
  }

  Future<void> getCartData() async {
    var result = await sharedPreferencesHelper.retrievePrefData("addCart");
    if (result.isNotEmpty) {
      var list = jsonDecode(result);
      debugPrint("list : $list");
      list.map((e) => cartList.add(CategoryResponse.fromJson(e))).toList();
      debugPrint("cart length : ${cartList.length}");
      debugPrint("cart : ${jsonEncode(cartList)}");
      print("${cartList[0].id}");
    }
  }

}
