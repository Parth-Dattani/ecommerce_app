import 'dart:convert';
import 'package:ecommerce_app/model/Image_Response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/model.dart';
import '../screen/screen.dart';
import '../services/service.dart';
import '../utils/utils.dart';
import 'controller.dart';

class HomeController extends BaseController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  RxList<SelectDrawer> drawerItems = RxList<SelectDrawer>();
  RxList<ImageResponse> resultDataList = <ImageResponse>[].obs;
  final getImagesModel = Rxn<ImageResponse>();
  RxList<CategoryResponse> cartList = <CategoryResponse>[].obs;
  RxList<dynamic> categoryList = <dynamic>[].obs;

  final List<String> imgList = [
    "https://picsum.photos/seed/picsum/200/300",
    "https://picsum.photos/200/300?grayscale",
    "https://picsum.photos/200/300/?blur",
    "https://picsum.photos/200/300/?blur=2",
  ];

  @override
  void onInit() {
    super.onInit();
    initList();
    getCartData();
    getCategory();
  }

  initList() {
    drawerItems.add(
        SelectDrawer(title: "Home", icon: Icons.home, selected: false));
    drawerItems.add(
        SelectDrawer(title: "Profile", icon: Icons.edit, selected: false));
    drawerItems.add(SelectDrawer(
        title: "Cart", icon: Icons.shopping_cart, selected: false));
    drawerItems.add(
        SelectDrawer(title: "Log out", icon: Icons.logout, selected: false));
  }

  drawerOnTap(index) {
    drawerItems[index].selected = !drawerItems[index].selected!;
    drawerItems
        .where((element) => element.title != drawerItems[index].title)
        .map((e) => e.selected = false)
        .toList();
    drawerItems.refresh();
    drawerItems[index].title == "Home"
        ? Get.back() /*Get.toNamed(HomeScreen.pageId,)*/
        : drawerItems[index].title == "Profile"
        ? Get.toNamed(ProfileScreen.pageId,)
        : drawerItems[index].title == "Cart"
        ? Get.toNamed(CartScreen.pageId,)
        : drawerItems[index].title == "logout"
        ? logOut()
        : null;
  }
  Future<void> logOut() async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    sharedPreferencesHelper.clearPrefData();
    Get.offAndToNamed(LoginScreen.pageId);
  }

  void getCategory() async {
    loader.value = true;
    var response = await RemoteServices.getCategory();
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData.isNotEmpty) {
        for (var i in jsonData) {
          categoryList.add(i);
        }
        //debugPrint("List : ${resultDataList[0].author}");
        loader.value = false;
      } else {
        loader.value = false;
      }
    }
  }

  Future<void> getCartData() async {
    var result = await sharedPreferencesHelper.retrievePrefData("addCart");
    if (result.isNotEmpty) {
      var list = jsonDecode(result);
      debugPrint("list : $list");
      list.map((e) => cartList.add(CategoryResponse.fromJson(e))).toList();
    }
  }
}

class SelectDrawer {
  String? title;
  IconData? icon;
  bool? selected;

  SelectDrawer({this.title, this.icon, this.selected});
}

