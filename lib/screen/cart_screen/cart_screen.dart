import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../widgets/widgets.dart';

class CartScreen extends GetView<CartController> {
  static const pageId = '/CartScreen';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Obx(
        ()=> CommonLoader(isLoad: controller.loader.value, body: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text("Cart Page"),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
          ),
          body:
          SafeArea(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(20.0),
                    height: 150,
                    width: double.infinity,
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
                        Image.network(controller.cartList[index].image.toString(), scale: 5, width: 200, fit: BoxFit.cover,),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(child: Text(controller.cartList[index].title.toString(),
                                overflow: TextOverflow.clip,
                                  maxLines: 2,
                                ),
                                ),
                                Text(controller.cartList[index].price.toString()),
                                Text(controller.cartList[index].category.toString()),
                                Text(controller.cartList[index].description.toString(),
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Container(height: 15,),
                itemCount: controller.cartList.length),
          ),
        ))
      );
  }

}
