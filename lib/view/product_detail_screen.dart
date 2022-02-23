import 'package:cached_map/cached_map.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shirleys/controllers/auth_controller.dart';
import 'package:shirleys/controllers/navigation_controller.dart';
import 'package:shirleys/controllers/product_detail_screen_controller.dart';
import 'package:shirleys/controllers/shop_cart_screen_controller.dart';
import 'package:shirleys/controllers/wish_list_controller.dart';
import 'package:shirleys/modal/cart_modal.dart';
import 'package:shirleys/modal/products.dart';
import 'package:shirleys/modal/wish_list_modal.dart';
import 'package:shirleys/statics.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:shirleys/view/SearchScreen.dart';
import 'package:shirleys/view/homepage.dart';
import 'package:shirleys/view/html_content_viewer.dart';
import 'package:shirleys/view/input_reviews.dart';
import 'package:shirleys/view/wishlist_screen.dart';
import 'package:shirleys/widgets/my_label.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'account views/html_viewer_screen.dart';
import 'home_tab.dart';
import 'user_review_screen.dart';
import 'shop_cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  Product product;

  AuthController authController = Get.find();
  ProductDetailScreenController productDetailScreenController;
  WishListController wishListController = Get.find();

  ProductDetailScreen({@required this.product}) {
    productDetailScreenController =
        Get.put(ProductDetailScreenController(product.obs));
    if(product.type!="")
      {
        Fluttertoast.showToast(msg: product.preOrderMessage,timeInSecForIosWeb: 3,gravity: ToastGravity.SNACKBAR,backgroundColor: AppColors.primaryColor);
      }
  }
  BottomBarController bottomBarController = Get.find();
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {

   print(productDetailScreenController.galleryLoading.value);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        title: Center(
          child: GestureDetector(
            onTap: (){
              bottomBarController.currentBNBIndex.value = 0;
              Get.to(HomePage());
              } ,
            child: Text(
              'SHIRLEYS',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20
              ),
            )
          )
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
      body:Obx(()=> SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height:Get.width,
                    width: Get.width,
                    child: Stack(
                      children: [
                        productDetailScreenController.currentChoiceID.value == null || productDetailScreenController.currentChoiceID.value == 0 ?
                    CachedNetworkImage(imageUrl: productDetailScreenController.product.value.photo,fit: BoxFit.cover,)
                            :
                        productDetailScreenController.galleryLoading.value?
                        Center(child: CircularProgressIndicator(),):
                        Carousel(
                                dotSize: 5,
                                dotSpacing: 10,
                                autoplay: false,
                                dotColor: Colors.white,
                                dotIncreasedColor: AppColors.primaryColor,
                                indicatorBgPadding: 5,
                                dotBgColor: Colors.transparent,
                                dotVerticalPadding: 5,
                                images: productDetailScreenController.productGalleryByID[productDetailScreenController.currentChoiceID.value].galleryItems.map((galleryItem) =>
                                    Hero(
                                        tag: product.id,
                                        child: CachedNetworkImage(imageUrl: galleryItem.photo,fit: BoxFit.cover,)),
                                ).toList(),
                              ),

                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: IconButton(
                              icon: Icon(
                                wishListController.items.any((element) => element.id==product.id)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: AppColors.primaryColor,),
                                onPressed: (){
                                  wishListController.addOrRemoveItem(product);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height*0.008,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width*0.6,
                              child: Text(
                                productDetailScreenController.product.value.title ,
                                style: TextStyle(
                                    fontSize: 18,

//                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              width: Get.width*0.3,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                                  product.type!=""?MyLabel(label: product.type,height: 20,width: 80,borderRadius: 3,fontSize: 12,):Container()

                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        GetX<ProductDetailScreenController>(
                            builder: (controller) {
                              return Row(
                                children:
                                      product.choices.length ==0 || product.choices.first.id == '1'? Container() :
                                product.choices.map((choice) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: controller.currentChoiceID.value == choice.id? AppColors.primaryColor:Colors.grey[300],
                                    child: GestureDetector(
                                      onTap: (){
                                        controller.currentChoiceID.value= choice.id;
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Color(int.parse(choice.color)),
                                        // backgroundImage: CachedNetworkImageProvider(choice.image,),
                                        radius: 18,
                                      ),
                                    ),
                                  ),
                                ),).toList(),
                              );
                            }
                        ),

                        productDetailScreenController.product.value.sizes.length ==0 || productDetailScreenController.product.value.sizes.first.id == '1'? Container() :
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sizes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            SizedBox(height: MediaQuery.of(context).size.height*0.008,),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children:productDetailScreenController.product.value.sizes.length==0?Container():  productDetailScreenController.product.value.sizes
                                      .map((size) => Container(
                                    margin: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.grey)
                                    ),
                                      child: Text('${size.title} ', style: TextStyle(fontSize: 18),textAlign: TextAlign.center,))).toList()
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        authController.isLogedIn.value ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {Get.to(InputReviewScreen(productId: product.id,));},
                                  child: Text('Rate this Product', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, decoration: TextDecoration.underline),)
                                ),
                                GestureDetector(
                                  onTap: () {

                                    Get.to(ReviewsScreen(productId: product.id,));
                                  },
                                  child: Row(
                                    children: [
                                      Text('(${product.reviews})', style: TextStyle(color: Colors.black, fontSize: 14),),
                                      SmoothStarRating(
                                        color: AppColors.primaryColor,
                                        rating: double.parse(product.rating),
                                        size: 15,
                                        isReadOnly: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                          ],
                        ): Container(),
                        GestureDetector(
                            onTap: (){
                              Get.to(HtmlContentViewer("Product Info",product.longDetails));
                            },
                            child: Text('Product Info', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),

                        product.sizeGuide.isEmpty?Container():
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(),
                            GestureDetector(
                                onTap: () {Get.to(HtmlContentViewer("Size Guide",product.sizeGuide));},
                              child: Text('Size Guide', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                            ),
                          ],
                        ),
                        Divider(),
                        // GestureDetector(
                        //   onTap: () {Get.to(HtmlContentViewer("Delivery",product.delivery));},
                        //   child: Text('Delivery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        // ),
                        // Divider(),
                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: Row(
                        //     children: imageUrlSlider.map((imageurl) => Row(
                        //       children: [
                        //         Column(
                        //           children: [
                        //             Container(
                        //               height: MediaQuery.of(context).size.height*0.4,
                        //               width: MediaQuery.of(context).size.width*0.42,
                        //               decoration: BoxDecoration(
                        //                 image: DecorationImage(
                        //                   image: ExactAssetImage(imageurl),
                        //                   fit: BoxFit.cover,
                        //                 ),
                        //               ),
                        //
                        //             ),
                        //             SizedBox(height: 5,),
                        //             Container(
                        //               height: MediaQuery.of(context).size.height*0.15,
                        //               width: MediaQuery.of(context).size.width*0.4,
                        //               child: Column(
                        //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                 children: [
                        //                   Text('Jack & Jones JACK & JONES Charcoal Grey Parka Coat',style: TextStyle(color: Colors.black, fontSize: 14),),
                        //                   SizedBox(height: 15,),
                        //                   Row(
                        //                     children: [
                        //                       Text('49.99\$',style: TextStyle(color: Colors.pink, fontSize: 12),),
                        //                       Text('\t \t49.99\$',style: TextStyle(color: Colors.pink, fontSize: 12,),),
                        //                     ],
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         SizedBox(width: 8,)
                        //       ],
                        //     ),).toList(),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: product.liveDate!=""?null:
                  () {
                product.sizes.length == 1?addToBag(product.sizes.first, product):
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) =>bottomSheet(),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color:product.liveDate!=""?Colors.black54: AppColors.primaryColor,
                ),
                height: 40,
                width: double.infinity,
                child: SizedBox(
                  height: 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      product.liveDate==""?
                      Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 20,)
                      :Container(),
                      Text(product.liveDate!=""?product.liveDate:'\tAdd to Cart',
                          style: TextStyle(color:
                          Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ), )
    );
  }

  Widget bottomSheet() {
    return Container(
      constraints: BoxConstraints(
          //   minHeight: Get.height*0.15,
          // maxHeight: Get.height*0.75,
          ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            constraints: BoxConstraints(
              minHeight: Get.height * 0.15,
              maxHeight: Get.height * 0.75,
            ),
            // height: Get.height*0.75-62,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                      height: 21,
                      child: Text(
                        'Select Size',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )),
                  Divider(),
                  ...productDetailScreenController.product.value.sizes
                      .map((size) => GestureDetector(
                            onTap: () async {
                              await addToBag(size, product);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(

                                color: Colors.grey.withOpacity(0.3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 15.0),
                                      child: Text(
                                        size.title,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList()
                ],
              ),
            )),
      ),
    );
  }
  Future<void> addToBag(Size size, Product product) async {
    Map json = product.toJson();

    // if(size.id==null){
    //   final Map<String, dynamic> data = new Map<String, dynamic>();
    //   data['id'] = '1';
    //   data['title'] = 'default_size';
    // json['size'] = data;
    // }else{
    //   json['size'] = size.toJson();
    // }


    /// adding quantity, size and choiceID to this raw json which isnt available in product's json and not Bag's json
    json['quantity'] = 1;
    json['size'] = size.toJson();
    json['choiceID'] = productDetailScreenController.currentChoiceID.value;
    json['photo'] = productDetailScreenController.product.value.photo;
    // json['photo'] = product.choices[product.choices.indexWhere((element) => element.id==productDetailScreenController.currentChoiceID.value)].image;
    Item item = Item.fromJson(json);

    CartController cartController = Get.find();
    cartController.addItem(item);
    Get.back();

  }
}


