import 'package:ecommerce_app/binding/binding.dart';
import 'package:ecommerce_app/binding/login_binding.dart';
import 'package:ecommerce_app/binding/register_binding.dart';
import 'package:ecommerce_app/screen/cart_screen/cart_screen.dart';
import 'package:ecommerce_app/screen/screen.dart';
import 'package:get/get.dart';

final List<GetPage> appPage = [
  GetPage(
      name: SplashScreen.pageId,
      page: ()=> SplashScreen(),
      binding: SplashBinding()
  ),

  GetPage(
      name: LoginScreen.pageId,
      page: ()=> const LoginScreen(),
      binding: LoginBinding()
  ),
  GetPage(
      name: RegisterScreen.pageId,
      page: ()=> RegisterScreen(),
      binding: RegisterBinding()
  ),
  GetPage(
      name: HomeScreen.pageId,
      page: ()=> HomeScreen(),
      binding: HomeBinding()
  ),

  GetPage(
      name: CartScreen.pageId,
      page: ()=> CartScreen(),
      binding: CartBinding()
  ),
];