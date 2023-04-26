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
  Rx<int> quantity = 1.obs;

  @override
  void onInit() {
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
    }
  }

}
