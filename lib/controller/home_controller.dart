import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/Image_Response.dart';
import 'package:ecommerce_app/screen/cart_screen/cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/model.dart';
import '../screen/screen.dart';
import '../services/service.dart';
import '../utils/utils.dart';
import 'controller.dart';

class HomeController extends BaseController {
  final auth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CollectionReference ref = FirebaseFirestore.instance.collection('user');
  User? user = FirebaseAuth.instance.currentUser;

  Rx<String> userName = "".obs;
  Rx<String> email = "".obs;
  Rx<String> uid = "".obs;
  UserModel loggedInUser = UserModel();
  Rxn<String> totalUsers = Rxn<String>();
  RxList<SelectDrawer> drawerItems = RxList<SelectDrawer>();
  Rx<int> selectedIndex = 0.obs;

  final Stream<QuerySnapshot> usersStream =
  FirebaseFirestore.instance.collection('users').snapshots();
  Rx<int> quantity = 1.obs;

  RxBool isFilter = true.obs;
  RxList<ImageResponse> resultDataList = <ImageResponse>[].obs;

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  ];

  @override
  void onInit() {
    super.onInit();
    initList();
    countUsers();
    getImages();
  }

  initList() {
    drawerItems.add(SelectDrawer(title: "Home", icon: Icons.home, selected: false));
    drawerItems.add(SelectDrawer(title: "Edit Profile", icon: Icons.edit, selected: false));
    drawerItems.add(SelectDrawer(title: "Cart", icon: Icons.shopping_cart, selected: false));
    drawerItems.add(SelectDrawer(title: "Log out", icon: Icons.logout, selected: false));
  }

  drawerOnTap(index) {
    drawerItems[index].selected = !drawerItems[index].selected!;
    drawerItems
        .where((element) => element.title != drawerItems[index].title)
        .map((e) => e.selected = false)
        .toList();
    drawerItems.refresh();
    drawerItems[index].title == "my_profile".tr
        ? Get.toNamed(CartScreen.pageId,
    )
        : drawerItems[index].title == "score_board".tr
        ? Get.toNamed(CartScreen.pageId,)
        : drawerItems[index].title == "change_password".tr
        ? Get.toNamed(
      CartScreen.pageId,
    )
        : drawerItems[index].title == "logout".tr
        ? logOut()
        : null;


  }

  Future<void> logOut() async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    sharedPreferencesHelper.clearPrefData();
    Get.offAndToNamed(LoginScreen.pageId);
  }

  void getImages() async {
    // try {
    loader.value = true;
    var response = await RemoteServices.getImageList();
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var data = jsonData['results'];
      if (data.isNotEmpty) {
        for (var i in data) {
          resultDataList.add(ImageResponse.fromJson(i));
        }
        debugPrint("List : ${resultDataList[0].author}");
        loader.value = false;
      } else {
        loader.value = false;
      }
    }
    // } catch (e) {debugPrint("Error :- ${e.toString()}");}
  }

  final CollectionReference<Map<String, dynamic>> userList =
      FirebaseFirestore.instance.collection('users');

  //get count of total user
  Future<void> countUsers() async {
    AggregateQuerySnapshot query = await userList.count().get();
    debugPrint('The number of users: ${query.count}');
    //usrCount = query.count;
    totalUsers.value = query.count.toString();
  }




}


class SelectDrawer {
  String? title;
  IconData? icon;
  bool? selected;

  SelectDrawer({this.title, this.icon, this.selected});
}

