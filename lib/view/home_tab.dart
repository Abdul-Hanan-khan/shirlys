import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:shirleys/controllers/featured_product_controller.dart';
import 'package:shirleys/controllers/navigation_controller.dart';
import 'package:shirleys/controllers/shop_cart_screen_controller.dart';
import 'package:shirleys/controllers/shop_controller.dart';
import 'package:shirleys/controllers/wish_list_controller.dart';
import 'package:shirleys/modal/featured_products_model.dart';
import 'package:shirleys/services/http_services.dart';
import 'package:shirleys/statics.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:shirleys/view/SearchScreen.dart';
import 'package:shirleys/view/product_detail_screen.dart';
import 'package:shirleys/view/products_screen.dart';
import 'package:shirleys/view/shop_screen.dart';
import 'package:shirleys/view/splash_screen.dart';
import 'package:shirleys/widgets/ImagePick.dart';
import 'package:shirleys/widgets/my_label.dart';

import '../widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

import 'shop_cart_screen.dart';

class HomeTab extends StatelessWidget {
  ShopController shopController = Get.find();
  CartController cartController = Get.find();
  BottomBarController bottomBarController = Get.find();


  FeaturedProductController featuredProductController=Get.find();
  WishListController _wishListController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Get.to(SearchScreen());
          },
          color: Colors.black,
        ),
        title: Center(
            child: Text(
          'SHIRLEYS',
          style: TextStyle(
              color: Colors.black,
//              letterSpacing: 3,
              fontSize: 20
            ),
          )
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(ShopCartScreen());
            },
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                    icon: Icon(Icons.shopping_bag_outlined),
                    onPressed: () {
                      Get.to(ShopCartScreen());
                    },
                    color: Colors.black),
                Obx(
                  () => Stack(
                    alignment: Alignment.center,
                    children: [
                      cartController.items.length == 0
                          ? Container()
                          : Icon(
                              Icons.circle,
                              color: AppColors.primaryColor,
                            ),
                      Text(
                        cartController.totalItems.value.toString(),
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: double.infinity,
                color: AppColors.primaryColor.withOpacity(0.3),
                child: Center(
                  child: Text(
                    'GET 10% OFF FOR YOUR FIRST ORDER',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
//                        letterSpacing: 3,
                        fontSize: 14),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              GestureDetector(
                onTap: () {
                  bottomBarController.currentBNBIndex.value = 1;
                  //TODO:
                },
                child: ImagePick(
                  imageUrl: 'assets/image/image7.jpeg',
                ),
              ),
              Container(
                color: AppColors.primaryColor.withOpacity(0.3),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Obx(
                    () => shopController.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 6 / 1.2,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0),
                            itemCount: shopController.categoriesHome.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                onTap: () {
                                  shopController.currentTabIndex.value = index;
                                  bottomBarController.currentBNBIndex.value = 1;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(0),
                                    //color: Color(0xffd9aaf6),
                                  ),
                                  child: Center(
                                      child: new Text(
                                    shopController.categoriesHome[index].title
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 16,
//                                        fontFamily: 'BebasNeue',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
//                                        letterSpacing: 2
                                        ),
                                  )),
//                          child: RaisedButton(
//                            onPressed: () {
//                              shopController.currentTabIndex.value = index;
//                              Get.to(ShopScreenTab());
//                            },
//                            color: Colors.white54,
//                            child: new Text(shopController.categories[index].title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                          ),
                                ),
                              );
                            }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('OUR FEATURED PRODUCTS',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),),
              ),
              // call horizontal list here
              Container(
                width: Get.width,
                height: 200,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: GetX<FeaturedProductController>(
                        builder: (featuredProductController) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: featuredProductController.productsModal.value.products.length??0,
                            itemBuilder: (BuildContext context, index)=>featuredItem(context,index,featuredProductController.productsModal.value.products[index]),
                          );
                        }
                    )
                ),
              ),





              ImagePick(
                imageUrl: 'assets/image/image2.jpeg',
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Container(
                width: double.infinity,
                height: Get.height * 0.4,
                child: Row(
                  children: [
                    Container(
                      width: Get.width * 0.48,
                      height: Get.height * 0.4,
                      child: Image(
                        image: AssetImage('assets/image/image4.jpeg'),
                        height: Get.height * 0.4,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Container(
                      width: Get.width * 0.48,
                      height: Get.height * 0.4,
                      child: Image(
                        image: AssetImage('assets/image/image5.jpeg'),
                        height: Get.height * 0.4,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ImagePick(
                imageUrl: 'assets/image/image6.jpeg',
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Container(
                width: double.infinity,
                height: Get.height * 0.4,
                child: Row(
                  children: [
                    Container(
                      width: Get.width * 0.48,
                      height: Get.height * 0.4,
                      child: Image(
                        image: AssetImage('assets/image/image8.jpeg'),
                        height: Get.height * 0.4,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Container(
                      width: Get.width * 0.48,
                      height: Get.height * 0.4,
                      child: Image(
                        image: AssetImage('assets/image/image1.jpeg'),
                        height: Get.height * 0.4,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ImagePick(
                imageUrl: 'assets/image/image9.jpeg',
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Container(
                width: double.infinity,
                height: Get.height * 0.4,
                child: Image(
                  image: AssetImage('assets/image/image11.jpeg'),
                  height: Get.height * 0.4,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget featuredItem(BuildContext context,int index,Product product){
    return Column(
      // mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                StaticVar.status='1';
                // Get.to(()=> ProductDetailScreen(product: product,));
                Get.to(()=> ProductsScreen(subCategoryID: product.subCategoryId, pageNo: 1, title: product.title));
              },
              child: Container(
                margin: EdgeInsets.only(right: 6),
                height: (Get.width/2)-50,
                width: (Get.width/2)-50,
                color: Colors.grey,
                child: Hero(
                  tag: product.id,
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: product.photo,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                        product.type!=""?Positioned(
                            right: 0,
                            bottom: 0,
                            child: MyLabel(label: product.type,height: 20,width: 80,borderRadius: 3,fontSize: 12,)):Container()

                      ],
                    ),
                  ),
                ),

              ),
            ),

          ],
        ),
        Padding(padding: EdgeInsets.all(2)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [


            Row(
              children: [
                double.parse(product.discountedPrice) == double.parse(product.salePrice)?
                Text(
                    '\$${product.salePrice}',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold ,
                        fontSize: 14,
                    ))
                    : Row(
                  children: [
                    Text(
                        '\$${product.salePrice}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold ,
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough
                        )),

                    Text(
                      '  \$${product.discountedPrice}',
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
      ],

    );
  }
}
