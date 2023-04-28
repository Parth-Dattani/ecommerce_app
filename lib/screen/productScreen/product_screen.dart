import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/controller/controller.dart';
import 'package:ecommerce_app/screen/cart_screen/cart_screen.dart';
import 'package:ecommerce_app/screen/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../../constant/constant.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class ProductScreen extends GetView<ProductController> {
  static const pageId = '/ProductScreen';

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CommonLoader(
        isLoad: controller.loader.value,
        body: Scaffold(
          //key: controller.scaffoldKey,
          appBar: CommonAppBar(
            title: "Product Screen",
            leadingIcon: ImagePath.arrowBack,
            leadingOnTap: () {
              controller.getCartData();
               Get.back();
            },
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      items: controller.imgList
                          .map((item) => ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Image.network(
                                item,
                                fit: BoxFit.cover,
                                width: 800,
                              )))
                          .toList(),
                      options: CarouselOptions(
                        height: 200.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction: 0.9,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Product List",
                      style: CustomTextStyle.headingText,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GridView.builder(
                      itemBuilder: (context, index) {
                        return controller.resultDataList.isNotEmpty
                            ? Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  //mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        child: Center(
                                          child: Image.network(
                                            controller.resultDataList[index].image.toString(),
                                            scale: 2,
                                            height: 90,
                                            width: 200,
                                            fit: BoxFit.fill,
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    dataList(
                                        "Name : ",
                                        controller.resultDataList[index].title
                                            .toString()),
                                    dataList(
                                        "Price : ",
                                        controller.resultDataList[index].price
                                            .toString()),
                                    dataList(
                                        "Category : ",
                                        controller
                                            .resultDataList[index].category
                                            .toString()),
                                    CommonButton(
                                      onPressed: () {
                                        for (int i = 0; i < controller.cartList.length; i++) {
                                          if (controller.cartList[i].id == controller.resultDataList[index].id) {
                                            controller.quantity.value++;
                                            print("qutity ${controller.quantity}");
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text("Item already in your cart")));
                                            //Get.back();
                                            return;
                                          }
                                        }
                                        print("cart Data Item :${controller.resultDataList[index].title} ");
                                        controller.cartList.add(controller.resultDataList[index]);
                                        sharedPreferencesHelper.storePrefData('addCart',
                                            jsonEncode(controller.cartList));
                                        Get.toNamed(CartScreen.pageId,
                                        arguments: {
                                          "quantity" : controller.quantity.value
                                        }
                                        );
                                        Common.errorSnackBar("Cart", "Product Added into Cart");
                                      },
                                      color: ColorConfig.colorGreenText,
                                      height: 30,
                                      child: Text(
                                        "Add to Cart",
                                        style: CustomTextStyle.addToCartText,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const Center(child: Text("No data Found"));
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 18,
                              childAspectRatio: 0.7),
                      itemCount: controller.resultDataList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.teal,
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("E-Commerce App"),
                  Text("Cart ${controller.cartList.length}"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dataList(title, description) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ),
        ),
        Flexible(
          child: Text(description,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1),
        ),
      ],
    );
  }
}
