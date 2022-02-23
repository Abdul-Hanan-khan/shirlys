import 'package:get/get.dart';
import 'package:shirleys/controllers/navigation_controller.dart';
import 'package:shirleys/modal/auth.dart';
import 'account views/account_screen.dart';
import 'package:shirleys/view/home_tab.dart';
import 'package:shirleys/view/shop_screen.dart';
import 'package:shirleys/view/wishlist_screen.dart';
import 'package:shirleys/widgets/ImagePick.dart';

import '../widgets/navigation_bar.dart';
import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {
  final bottomController = Get.put(BottomBarController());
  List _tabs = [
    HomeTab(),
    ShopScreenTab(),
    WishListScreenTab(),
    AccountScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Obx(
          ()=>_tabs[bottomController.currentBNBIndex.value]
      ),
      bottomNavigationBar: BottomNavigateBar(),
    );
  }

}