import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../widgets/widgets.dart';

class CartScreen extends GetView<CartController> {
  static const pageId = '/CartScreen';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => CommonLoader(
        isLoad: controller.loader.value,
        body: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text("Cart Page"),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
          ),
          body: SafeArea(
            child: controller.cartList.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(20.0),
                        height: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 7,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              controller.cartList[index].image.toString(),
                              scale: 5,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        controller.cartList[index].category
                                            .toString(),
                                      ),
                                    ),
                                    Text(
                                        "₹${controller.cartList[index].price.toString()}"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      controller.cartList[index].title
                                          .toString(),
                                      overflow: TextOverflow.clip,
                                      maxLines: 2,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      controller.cartList[index].description
                                          .toString(),
                                      overflow: TextOverflow.clip,
                                      maxLines: 2,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      child: Obx(
                                        () => Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    blurRadius: 7,
                                                  )
                                                ],
                                              ),
                                              child: IconButton(
                                                  icon:
                                                      const Icon(Icons.remove),
                                                  onPressed: () {
                                                    controller.cartList[index].quantity == 0 ? 0 :
                                                    controller.cartList[index]
                                                        .quantity--;
                                                    controller.cartList
                                                        .refresh();
                                                  }),
                                            ),
                                            Text(
                                                "Qty :${controller.cartList[index].quantity}"),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    blurRadius: 7,
                                                  )
                                                ],
                                              ),
                                              child: IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  controller.cartList[index]
                                                      .quantity++;
                                                  controller.cartList.refresh();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Container(
                          height: 15,
                        ),
                    itemCount: controller.cartList.length)
                : const Center(
                    child: Text("Your Cart is empty"),
                  ),
          ),
        )));
  }
}
