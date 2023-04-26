import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/screen/productScreen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/constant.dart';
import '../../controller/controller.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends GetView<HomeController> {
  static const pageId = '/HomeScreen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> CommonLoader(
        isLoad: controller.loader.value,
        body : Scaffold(
          key: controller.scaffoldKey,
          appBar:  CommonAppBar(
            title: "Home Screen",
            leadingIcon: ImagePath.drawerIcon,
            leadingOnTap: (){
              debugPrint("TAp");
              //Scaffold.of(context).openDrawer();
              controller.scaffoldKey.currentState?.isDrawerOpen;
              controller.scaffoldKey.currentState?.openDrawer();
            },
            actionIcon: ImagePath.logOutIcon,
            actionIconSize: 2,
            actionOnTap: (){
              controller.logOut();
            },
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
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
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        viewportFraction: 0.9,
                      ),
                    ),
                    const SizedBox(height: 15,),
                     Text("Category", style: CustomTextStyle.headingText,),
                    const SizedBox(height: 15,),
                    GridView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            debugPrint("sfsdf ${controller.categoryList[index]}");
                            Get.toNamed(ProductScreen.pageId,
                            arguments: {
                              "category" : controller.categoryList[index].toString()
                            }
                            );

                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.teal
                            ),
                            child: Center(child: Text(controller.categoryList[index])),
                          ),
                        );
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 18,
                      ),
                      itemCount: controller.categoryList.length,
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
                  Text("Cart : ${controller.cartList.length}"),
                ],
              ),
            ),
          ),
          drawer: drawer(),
        ),
      ),
    );
  }

  Widget drawer (){
    return Obx(
          ()=> Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 250,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: ColorConfig.colorPrimary,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        ImagePath.profileLogo,
                        scale: 5,
                        //height: 50,width: 78,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(controller.user!.email.toString(), style: CustomTextStyle.buttonText,),
                  ],
                ),
              ),
            ),
            Column(
              children: List.generate(
                controller.drawerItems.length,
                    (index) =>
                    Column(
                      children: [
                        ListTile(
                          selected: controller.drawerItems[index].selected ?? false,
                          selectedColor: ColorConfig.colorPrimary,
                          leading: Icon(controller.drawerItems[index].icon ?? (Icons.ssid_chart),
                            color: ColorConfig.colorLightBlack,
                            size: 30,
                          ),
                          title: Text(
                            controller.drawerItems[index].title ?? '',
                            style:  CustomTextStyle.linkText,
                          ),
                          onTap: () {
                            controller.drawerOnTap(index);
                          },
                        ),
                        const Divider(indent: 60,thickness: 1,color: ColorConfig.colorLightGrey),
                      ],
                    ),
              ),
            ),
          ],
        ),),
    );
  }



}
