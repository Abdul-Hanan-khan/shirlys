import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirleys/controllers/navigation_controller.dart';
import 'package:shirleys/controllers/wish_list_controller.dart';
import 'package:shirleys/utils/AppSettings.dart';

class BottomNavigateBar extends StatelessWidget {
  WishListController _wishListController = Get.find();
  BottomBarController bottomController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetX<BottomBarController>(
        builder: (controller) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            currentIndex: controller.currentBNBIndex.value,
            onTap: controller.indexChanged,
            selectedItemColor: Color(0xff9D84F7),
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
               icon: Obx(
                      () => Stack(
                        alignment: _wishListController.items.length == 0
                            ? Alignment.center
                            : Alignment.topRight,
                        children: [
                          Icon(Icons.favorite_border),
                          _wishListController.items.length == 0
                              ? Container()
                              :Transform.translate(
                                offset: Offset(
                                  5,0
                                ),
                                child:
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(Icons.circle, color: AppColors.primaryColor,size: 15,),
                                    Text(_wishListController.items.length.toString(), style: TextStyle(color: Colors.white,fontSize: 8),)
                              ],
                            ),
                          ),
                        ],
                      ),
                ),
                // icon: Icon(Icons.favorite_border),
                label: 'WishList',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity),
                label: 'Account',
              ),
            ],
          );
        }
    );
  }
}