import 'package:ecommerce_app/binding/binding.dart';
import 'package:ecommerce_app/screen/productScreen/product_screen.dart';
import 'package:ecommerce_app/screen/screen.dart';
import 'package:get/get.dart';

final List<GetPage> appPage = [
  GetPage(
      name: SplashScreen.pageId,
      page: ()=> const SplashScreen(),
      binding: SplashBinding()
  ),

  GetPage(
      name: LoginScreen.pageId,
      page: ()=> const LoginScreen(),
      binding: LoginBinding()
  ),
  GetPage(
      name: RegisterScreen.pageId,
      page: ()=> const RegisterScreen(),
      binding: RegisterBinding()
  ),
  GetPage(
      name: HomeScreen.pageId,
      page: ()=> const HomeScreen(),
      binding: HomeBinding()
  ),
  GetPage(
      name: ProductScreen.pageId,
      page: ()=> ProductScreen(),
      binding: ProductBinding()
  ),

  GetPage(
      name: ProfileScreen.pageId,
      page: ()=> ProfileScreen(),
      binding: ProfileBinding()
  ),
  GetPage(
      name: CartScreen.pageId,
      page: ()=> CartScreen(),
      binding: CartBinding()
  ),
];