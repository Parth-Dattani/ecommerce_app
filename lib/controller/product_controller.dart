import 'dart:convert';
import 'package:ecommerce_app/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/model.dart';
import '../services/service.dart';

class ProductController extends BaseController{

  final List<String> imgList = [
    "https://picsum.photos/seed/picsum/200/300",
    "https://picsum.photos/200/300?grayscale",
    "https://picsum.photos/200/300/?blur",
    "https://picsum.photos/200/300/?blur=2",
  ];

  RxList<CategoryResponse> resultDataList = <CategoryResponse>[].obs;
  RxList<CategoryResponse> cartList = <CategoryResponse>[].obs;
  String? category = 'jewelery';

  @override
  void onInit() {
    //getNews();
    category = Get.arguments["category"];
    categoryNews(category);
    super.onInit();
  }

  void categoryNews(category) async {
    try {
      resultDataList.clear();
      loader.value = true;
      var response = await RemoteServices.categoryName(category);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData.isNotEmpty) {
          loader.value = false;
          for (var i in jsonData) {
            resultDataList.add(CategoryResponse.fromJson(i));
          }
          loader.value = false;
        } else {
          loader.value = false;
        }
      }
    } catch (e) {
      debugPrint("Error :- ${e.toString()}");
    }
  }
}