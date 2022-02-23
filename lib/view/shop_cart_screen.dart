import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirleys/controllers/navigation_controller.dart';
import 'package:shirleys/controllers/shop_cart_screen_controller.dart';
import 'package:shirleys/modal/auth.dart';
import 'package:shirleys/modal/products.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:shirleys/view/homepage.dart';
import 'package:shirleys/view/order_screen.dart';
import 'package:shirleys/view/product_detail_screen.dart';
import 'package:shirleys/view/shop_screen.dart';
import 'package:shirleys/widgets/AlertDialogeWidget.dart';
import 'account views/create_account_screen.dart';

class ShopCartScreen extends StatelessWidget {
CartController cartController = Get.find();
BottomBarController bottomBarController = Get.find();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Cart', style: TextStyle(color: Colors.black,),),
      ),
      body: SafeArea(
        child: Obx(
            () => cartController.items.length==0?
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_bag_outlined, size: 60, color: Colors.black38,),
                        Text('Your Bag is Empty',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text('Use the app to add products to your bag.',
                          style: TextStyle(
                            fontSize: 18
                          ),
                          textAlign: TextAlign.center,
                        ),

                        //),
                        // listItem(1),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      bottomBarController.currentBNBIndex.value = 1;
                      Get.to(HomePage());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 40,
                      width: double.infinity,
                      child: Center(child: Text('Shop Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18),)),
                    ),
                  ),
                ],
              ),
            ),
          ): //Todo:// replace this container with your UI
          Obx((){
            int totalItems=0;
            double totalPrice=0;
            cartController.items.forEach((item) {
              totalItems=totalItems+item.quantity;
              totalPrice+=(double.parse(item.discountedPrice)*item.quantity);
            });
            return  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          children: [
                            SizedBox(height: 10,),
                            ...cartController.items.map((item) =>
                                Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Get.to(()=> ProductDetailScreen(product: Product.fromJson(item.toJson())));
                                        },
                                        child: Container(

                                          decoration: BoxDecoration(
                                            // borderRadius: BorderRadius.circular(15),
                                            color: Colors.white70,
                                            image: DecorationImage(image: NetworkImage(item.photo,),fit: BoxFit.cover,)
                                          ),
                                          width: Get.width*0.3,
                                          height: Get.width*0.3,
//                                    child: CachedNetworkImage(imageUrl: item.photo,fit: BoxFit.cover,
//                                      width: Get.width*0.3,
//                                      height: Get.height*0.25,
//                                    ),
                                        ),
                                      ),
                                      // Image.network(
                                      //   item.photo,
                                      //   fit: BoxFit.contain,
                                      //   width: Get.width*0.3,
                                      //   height: Get.height*0.25,
                                      // ),
                                      SizedBox(width: 10,),
                                      Container(
                                        width: Get.width*0.5,
                                        //color: Colors.blue,
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.title,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
//                                              letterSpacing: 1,
                                              ),
                                            ),
                                            SizedBox(height: 7,),


                                            item.size.id == '1'?Container(): Text(
                                              'Size : ${item.size.title}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),SizedBox(height: 7,),
                                            item.choiceID == '1'?Container(): CircleAvatar(
                                              radius: 20,
                                              // backgroundColor: item.choic.value == choice.id? AppColors.primaryColor:Colors.grey[300],
                                              child: CircleAvatar(
                                                backgroundColor: Color(int.parse(item.choices[0].color)),
                                                // backgroundImage: CachedNetworkImageProvider(choice.image,),
                                                radius: 18,
                                              ),
                                            ),
                                            // CircleAvatar(backgroundColor: Color(int.parse(item.c)),),
                                            SizedBox(height: 7,),
                                           Row(
                                             children: [
                                               Text(
                                                 '${item.quantity} x \$${item.salePrice}',
                                                 style: TextStyle(
                                                   color: Colors.black,
                                                   fontSize: 14,
                                                 ),
                                               ),
                                               SizedBox(width: 5,),
                                               Text(
                                                 '= \$${(double.parse(item.discountedPrice)*item.quantity).toStringAsFixed(2)}',
                                                 style: TextStyle(
                                                     color: Colors.black,
                                                     fontSize: 14,
                                                     fontWeight: FontWeight.bold
                                                 ),
                                               ),
                                             ],
                                           )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            IconButton(
                                              onPressed: (){
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialogWidget(
                                                      onPositiveClick: () {
                                                        cartController.removeItem(item);
                                                        Get.back();
                                                      },
                                                      title: "Remove Item",
                                                      subTitle: "Are you sure to delete this item?",
                                                    );
                                                  },
                                                );
//                                              cartController.removeItem(item);
                                              },
                                              icon: Icon(Icons.delete_outlined),
                                            ),


                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              ),
                            ),).toList(),
                          ]
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$totalItems Items', style: TextStyle(fontSize: 16, letterSpacing: 1,),),
                          Text('Total \$${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, letterSpacing: 1,),),
                        ],
                      ),
                      FlatButton(
                        onPressed: (){

//                        User user = await User.fromCache();
//                        if(user != null)
//                          {
//                            Get.to(OrderScreen(totalAmount: totalPrice,));
//                          }
//                        else
                            Get.to(OrderScreen(totalAmount: totalPrice,));
                          },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: 40,
                          width: double.infinity,
                          child: Center(
                            child: Text('Checkout Securely',
                              style: TextStyle(
//                              fontFamily: 'BebasNeue',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
//                              letterSpacing: 1,
                              ),
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
            }
          ),
        ),
      )
    );
  }
}

