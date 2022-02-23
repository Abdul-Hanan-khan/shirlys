import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirleys/controllers/auth_controller.dart';
import 'package:shirleys/controllers/shop_cart_screen_controller.dart';
import 'package:shirleys/modal/auth.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:shirleys/view/SearchScreen.dart';
import 'package:shirleys/view/account%20views/account_detail_screen.dart';
import 'package:shirleys/view/account%20views/create_account_screen.dart';
import 'package:shirleys/view/account%20views/sign_in_screen.dart';
import 'package:shirleys/view/dummy/copy_orderhistory.dart';
import 'package:shirleys/view/homepage.dart';
import 'package:shirleys/widgets/AlertDialogeWidget.dart';
import 'contact_us_screen.dart';
import 'package:shirleys/view/order_history_screen.dart';
import 'package:shirleys/view/shop_cart_screen.dart';
import 'html_viewer_screen.dart';

class AccountScreen extends StatelessWidget {
  AuthController controller = Get.find();
  CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.search), onPressed: () {Get.to(SearchScreen());}, color: Colors.black,),
        title: Center(
          child: GestureDetector(
            onTap: (){Get.to(HomePage());} ,
            child: Text('SHIRLEYS',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
//                  letterSpacing: 2
              ),
            )
          )
        ),
        actions: [

          GestureDetector(
            onTap: (){Get.to(ShopCartScreen());},
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(icon: Icon(Icons.shopping_bag_outlined), onPressed: () {Get.to(ShopCartScreen());}, color: Colors.black),
                Obx(
                      () => Stack(
                    alignment: Alignment.center,
                    children: [
                      cartController.items.length == 0
                          ? Container()
                          : Icon(Icons.circle, color: AppColors.primaryColor,),
                      Text(cartController.totalItems.value.toString(), style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body:Obx(()=> controller.isLogedIn.value
      ? SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // Get.to(OrderHistoryScreen());
                    Get.to(CopyOrderHistoryScreen());

                    },
                  child: Text(
                    'Order History',
                    style: TextStyle(
                      fontSize: 20,
//                    letterSpacing: 2,
                      color: Colors.black
                    ),
                  )
                ),
                SizedBox(height: 20,),
                GestureDetector(
                    onTap: () {Get.to(AccountDetailScreen());},
                    child: Text(
                      'Account Details',
                      style: TextStyle(
                        fontSize: 20,
//                      letterSpacing: 2,
                        color: Colors.black
                      ),
                    )
                ),
                SizedBox(height: 20,),
                GestureDetector(
                    onTap: () {Get.to(HtmlViewer("2"));},
                    child: Text(
                      'Delivery & Returns',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
//                      letterSpacing: 2
                      ),
                    )
                ),
                SizedBox(height: 20,),
                GestureDetector(
                    onTap: () {Get.to(ContactUsScreen());},
                    child: Text(
                      'Contact Us',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
//                      letterSpacing: 2
                      ),
                    )
                ),
                SizedBox(height: 20,),
                GestureDetector(
                    onTap: () {Get.to(HtmlViewer('3'));},
                    child: Text(
                      'FAQs',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
//                      letterSpacing: 2
                      ),
                    )
                ),
                SizedBox(height: 20,),
                GestureDetector(
                    onTap: () {Get.to(HtmlViewer("4"));},
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
//                      letterSpacing: 2
                      ),
                    )
                ),
                SizedBox(height: 20,),
                GestureDetector(
                    onTap: () {Get.to(HtmlViewer("5"));},
                    child: Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
//                      letterSpacing: 2
                      ),
                    )
                ),
                SizedBox(height: 20,),
                Divider(),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialogWidget(
                          title: 'Logout Alert',
                          subTitle: "Do you want to logout from your account?",
                          onPositiveClick: () {
                            controller.logOut();
                            Get.back();
                          },
                        );
                      }
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 40,
                    width: double.infinity,
                    child: Center(
                      child: Text('Log Out',
                        style: TextStyle(
//                        fontFamily: 'BebasNeue',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
//                        letterSpacing: 2
                        ),
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
      )
      : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {Get.to(HtmlViewer("2"));},
                  child: Text(
                    'Delivery & Returns',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
//                    letterSpacing: 2
                    ),
                  )
              ),
              SizedBox(height: 20,),
              GestureDetector(
                  onTap: () {Get.to(ContactUsScreen());},
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
//                    letterSpacing: 2
                    ),
                  )
              ),
              SizedBox(height: 20,),
              GestureDetector(
                  onTap: () {Get.to(HtmlViewer("3"));},
                  child: Text(
                    'FAQs',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
//                    letterSpacing: 2
                    ),
                  )
              ),
              SizedBox(height: 20,),
              GestureDetector(
                  onTap: () {Get.to(HtmlViewer("4"));},
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
//                    letterSpacing: 2
                    ),
                  )
              ),
              SizedBox(height: 20,),
              GestureDetector(
                  onTap: () {Get.to(HtmlViewer("5"));},
                  child: Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
//                    letterSpacing: 2
                    ),
                  )
              ),
              SizedBox(height: 20,),
              Divider(),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {Get.to(CreateAccountScreen(returnToOrderScreen:false));},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 40,
                  width: double.infinity,
                  child: Center(
                    child: Text('Create Account',
                      style: TextStyle(
                        color: Colors.black,
//                      fontFamily: 'BebasNeue',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
//                      letterSpacing: 2
                      ),
                    )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {Get.to(()=>SignInScreen(returnToOrderScreen:false));},
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 40,
                  width: double.infinity,
                  child: Center(
                      child: Text('Sign In',
                      style: TextStyle(
//                    fontFamily: 'BebasNeue',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
//                      letterSpacing: 2
                      ),
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      )
      )
    );
  }
}
