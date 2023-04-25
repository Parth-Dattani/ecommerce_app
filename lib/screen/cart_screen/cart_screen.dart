import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/text_style.dart';
import '../../controller/controller.dart';
import '../../widgets/widgets.dart';
import 'widget/cart_item.dart';

class CartScreen extends GetView<CartController> {
  static const pageId = '/CartScreen';

  @override
  Widget build(BuildContext context) {
    return
      Obx(
        ()=> CommonLoader(isLoad: controller.loader.value, child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text("Cart Page"),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
          ),
          body:
          // controller.getCartData == null
          //     ? const Center(
          //   child: Text("Your Cart is empty"),
          // )
          //     :
          SafeArea(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('cart')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('cart_2')
                  .snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  controller.getCartData = snapshot.data!.docs;
                  return Column(
                    children: [
                      Expanded(
                        child:  ListView.builder(
                          itemBuilder: (context, index) {
                            return CartItem(
                              index: index,
                              productId: controller.getCartData[index]['productID'],
                              productCategory: controller.getCartData[index]['category'],
                              productImage: controller.getCartData[index]['imageUrl'],
                              productPrice: controller.getCartData[index]['price'],
                              productQuantity: controller.quantity.value,
                              //productQuantity: controller.getCartData[index]["quantity"],
                              productName: controller.getCartData[index]['productName'],
                              //cartId: controller.getCartData[index]['cartID'],
                            );
                          },
                          itemCount: controller.getCartData.length,
                        ),
                      ),
                      const Divider(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.98),
                                blurRadius: 20,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "data",
                              ),
                              Center(
                                child: CommonButton(
                                    color: Colors.green,
                                    height: 40,
                                    width: Get.width*0.90,
                                    onPressed: () {

                                      print("object:${controller.getCartData.length}");
                                      for (int i = 0; i <= controller.getCartData.length - 1; i++) {
                                        print("============================================");
                                        print("Item ${i + 1}: ");
                                        print("price:${controller.getCartData[i]['price']}");
                                        print("Qty:${controller.getCartData[i]['quantity']}");
                                        controller.total = controller.getCartData[i]['quantity'] *
                                            controller.getCartData[i]['price'];
                                        controller.subTotal += controller.total;
                                        print("total: ${controller.total}");
                                        // tot =  controller.getCartData[i]['quantity'] * controller.getCartData[i]['price'];
                                        // print(tot);
                                      }
                                      print("============================================");
                                      print("Sub Total : ${controller.subTotal}");
                                      print("============================================");

                                      // Get.toNamed(
                                      //     CheckOutScreen.pageId,
                                      //     arguments: {
                                      //       'price': controller.price,
                                      //       'qty': controller.quantity,
                                      //       'total' : controller.total,
                                      //       'subTotal' : controller.subTotal
                                      //     }
                                      // );
                                    },
                                    child: Text("Check Out",style:  CustomTextStyle.buttonText)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [Text("no data"), CircularProgressIndicator()],
                  ),
                );
              },
            ),
          ),
        ))
      );
  }
}
