import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/constant.dart';
import '../../controller/controller.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends GetView<HomeController> {
  static const pageId = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(height: 15,),
                Text("Category"),
                GridView.builder(
                  itemBuilder: (context, index) {

//               .doc(list[index].productID)
//               .get()
//               .then(
//                 (DocumentSnapshot doc) {
//                   controller.favData.value = doc.data() as Map<String, dynamic>;
//                   // final data = doc.data() as Map<String, dynamic>;
// // List<String> s = [];
//                   print("Fav product data geting  datat: ${controller.favData
//                       .value.containsValue("QB2lvfzaAfd9eVPVI5jQ")}");
//                 }
// //               print("favId from data : ${data['productId']}");
// //               data.forEach((key, value) {
// //                 s.add(value);
// //               });
// //               print("s list data : ${s[0]}" );
// //               // ...
// //             },
// //             onError: (e) => print("Error getting document: $e"),
//
//           );
                    // var favId =
                    // FirebaseFirestore.instance
                    //     .collection("favorite")
                    //     .doc(FirebaseAuth.instance.currentUser!.uid)
                    //     .collection("userFavorite")
                    //     .doc(list[index].productID)
                    //     .get();
                    //
                    // print("Fav product data geting : $favId");
                    //     .then((value)  {
                    //        print("Fav product data geting : ${value[0]}");
                    //   // if (this.mounted)
                    //   //   {
                    //   // if (value.exists)
                    //   //   {
                    //   //     controller.isFavorite.value = value.get("productFavorite"),
                    //   //     print("df fav ${controller.isFavorite.value}"),
                    //   //   }
                    //   //}
                    // },
                    // );
                    return Column(
                      children: [
                        controller.imgList.isEmpty
                            ? const Text("No data")
                            : Expanded(
                          child: GestureDetector(
                            onTap: () {
                              //productView(context, list[index]);
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                      width: 200,
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          child: Center(
                                            child: Image.network(
                                             controller.imgList[index].toString(),
                                            ),
                                          ))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  dataList("Name : ", "sdf"),
                                  dataList("Price : ", "350"),
                                  dataList("Category : ","moinbc"),
                                  dataList("Qty : ", "20"),
                                  dataList("", ""),

                                  CommonButton(
                                    child: Text("Add TO Cart", style: CustomTextStyle.addToCartText),
                                    color: ColorConfig.colorGreenText,

                                    onPressed: (){},
                                  ),
                                  /*Text(
                                  "Description : ${getProduct[index].get("description")}",
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500),
                                ),*/
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 18,
                      childAspectRatio: 0.65),
                  itemCount: controller.imgList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                ),
                Container(
                  decoration: BoxDecoration(

                    color: ColorConfig.colorBlur,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("data"),
                        Text("data"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: drawer(),
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
                    CircleAvatar(
                      radius: 60,
                      child: Image.network(/*controller.userImage.value,*/
                      controller.imgList[1],scale: 25,fit: BoxFit.fill),
                    ),

                    const SizedBox(height: 10,),
                    Text("controller.emailId.value", style: CustomTextStyle.buttonText,),
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
        Expanded(
          child: Text(
            description,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

}
