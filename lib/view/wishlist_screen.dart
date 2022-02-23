import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirleys/controllers/shop_cart_screen_controller.dart';
import 'package:shirleys/controllers/wish_list_controller.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:shirleys/view/SearchScreen.dart';
import 'package:shirleys/view/product_detail_screen.dart';
import 'package:shirleys/view/shop_screen.dart';
import 'shop_cart_screen.dart';



class WishListScreenTab extends StatelessWidget {
  CartController _cartController = Get.find();
  WishListController controller  = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.search), onPressed: () {Get.to(SearchScreen());}, color: Colors.black,),
        title: Center(child: GestureDetector(child: Text('SHIRLEYS', style: TextStyle(color: Colors.black, letterSpacing: 2, fontSize: 20),))),
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
                      _cartController.items.length == 0
                          ? Container()
                          : Icon(Icons.circle, color: AppColors.primaryColor,),
                      Text(_cartController.totalItems.value.toString(), style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body:



      Obx(()=>
        controller.items.length==0?Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 60, color: Colors.black38,),
                  Text('Your WishList is Empty',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
//                        letterSpacing: 2
                    ),
                    textAlign: TextAlign.center,),
                  Text('Love a Product? Add it to your favorites by tapping the heart',
                    style: TextStyle(
                        fontSize: 18,
//                        letterSpacing: 2
                    ),
                    textAlign: TextAlign.center,),

                  //),
                  // listItem(1),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                Get.to(ShopScreenTab());
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
      ):
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    children: [
                      SizedBox(height: 10,),
                      ...controller.items.map((item) =>
                          Container(
                            child: GestureDetector(
                              onTap: (){Get.to(()=> ProductDetailScreen(product: item));},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(

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
                                            SizedBox(height: 10,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                double.parse(item.discountedPrice) == double.parse(item.salePrice)?
                                                Text(
                                                    '\$${item.salePrice}',
                                                    style: TextStyle(
                                                      color: AppColors.primaryColor,
                                                      fontWeight: FontWeight.bold ,
                                                      fontSize: 14,
                                                    ))
                                                    : Row(
                                                  children: [
                                                    Text(
                                                        '\$${item.salePrice}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight: FontWeight.bold ,
                                                            fontSize: 12,
                                                            decoration: TextDecoration.lineThrough
                                                        )),

                                                    Text(
                                                      '  \$${item.discountedPrice}',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: AppColors.primaryColor,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
//                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                              onPressed: (){
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Remove Item", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
                                                      content: Text("Are you sure to remove this item from wishlist?",),
                                                      actions: [
                                                        TextButton(
                                                          child: Text(
                                                              'No',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  letterSpacing: 1,
                                                                  color: AppColors.primaryColor,
                                                                  fontWeight: FontWeight.bold)
                                                          ),
                                                          onPressed: (){Get.back();},
                                                        ),
                                                        TextButton(
                                                          child: Text(
                                                            'Yes',
                                                            style: TextStyle(
                                                                letterSpacing: 1,
                                                                fontSize: 16,
                                                                color: AppColors.primaryColor,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          onPressed: (){
                                                            controller.removeItem(item);
                                                            Get.back();
                                                          },
                                                        ),
                                                      ],
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
                            ),
                          ),).toList(),
                    ]
                ),
              ),
            ),

          ],
        ),
      )
     ),
    );
  }


}


