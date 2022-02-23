import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirleys/controllers/product_controller.dart';
import 'package:shirleys/controllers/shop_cart_screen_controller.dart';
import 'package:shirleys/controllers/wish_list_controller.dart';
import 'package:shirleys/modal/products.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:shirleys/view/SearchScreen.dart';
import 'package:shirleys/view/home_tab.dart';
import 'package:shirleys/view/product_detail_screen.dart';
import 'package:shirleys/view/shop_cart_screen.dart';
import 'package:shirleys/widgets/my_label.dart';

class ProductsScreen extends StatelessWidget {
  String subCategoryID;
  int pageNo;
  String title;
  ProductController productController;
  WishListController _wishListController = Get.find();
  ProductsScreen({@required this.subCategoryID,@required this.pageNo, @required this.title}){
   productController = Get.put(ProductController(subCategoryID: subCategoryID, pageNo: pageNo));
}

  CartController cartController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        title: Text(title,
          style: TextStyle(
            color: Colors.black,
//            letterSpacing: 2,
            fontSize: 20
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {Get.to(SearchScreen());}, color: Colors.black,),
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
      body:Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: GetX<ProductController>(
            builder: (productController) {
              return GridView.builder(
                itemCount: productController.productsModal.value.products.length??0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1/1.25,
                ),
                itemBuilder: (BuildContext context, index)=>gridItem(context,index,productController.productsModal.value.products[index]),
              );
            }
          )
        ),

    );
  }
  Widget gridItem(BuildContext context,int index,Product product){
    return Column(
      // mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(()=> ProductDetailScreen(product: product));
              },
              child: Container(
                height: (Get.width/2)-10,
                width: (Get.width/2)-10,
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
//         SizedBox(height: 5,),
//         Text(product.title,
//           maxLines: 3,
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 16,
// //              letterSpacing: 2,
// //              fontWeight: FontWeight.bold
//           ),
//         ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [


                Row(
                  children: [
                    product.discountedPrice == product.salePrice?
                    Text(
                        '\$${product.salePrice}',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold ,
                            fontSize: 14,
//                  letterSpacing: 2,
                            decoration: TextDecoration.lineThrough
                        ))
                        :
                    Text(
                        '\$${product.salePrice}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold ,
                            fontSize: 12,
//                  letterSpacing: 2,
                            decoration: TextDecoration.lineThrough
                        )),

                    Text(
                      '  \$${product.discountedPrice}',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.primaryColor,
//                  letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),



            Obx(
                  ()=> IconButton(
                    onPressed: (){
                      _wishListController.addOrRemoveItem(product);
                    },
                    icon: _wishListController.items.any((element) => element.id==product.id)

                        ? Icon(Icons.favorite, color: AppColors.primaryColor)
                        : Icon(Icons.favorite_border, color: AppColors.primaryColor),
                  ),
            ),
          ],
        ),
      ],

    );
  }
}


