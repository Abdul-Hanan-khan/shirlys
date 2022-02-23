import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirleys/controllers/auth_controller.dart';
import 'package:shirleys/controllers/featured_product_controller.dart';
import 'package:shirleys/controllers/shop_cart_screen_controller.dart';
import 'package:shirleys/controllers/shop_controller.dart';
import 'package:shirleys/controllers/wish_list_controller.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:shirleys/view/products_screen.dart';
import 'package:shirleys/view/splash_screen.dart';
import 'controllers/navigation_controller.dart';
import 'view/homepage.dart';

void main() {
  final shopController = Get.put(ShopController());
  final bottomController = Get.put(BottomBarController());
  final featuredController=Get.put(FeaturedProductController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    final authController = Get.put(AuthController());
    final wishListController = Get.put(WishListController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
//        primaryColor: Color(0xfff0d6fa),
        fontFamily: 'DMSans',
        primarySwatch: AppColors.primaryColor,
        accentColor: AppColors.primaryColor,
        primaryColor: AppColors.primaryColor,
        appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
          brightness: Brightness.dark,
      ),),
      home:
//
      // TestScreen(),
      SplashScreen(),
    );

  }
}
