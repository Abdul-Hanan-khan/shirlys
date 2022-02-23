
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shirleys/controllers/navigation_controller.dart';
import 'package:shirleys/controllers/shop_cart_screen_controller.dart';
import 'package:shirleys/controllers/shop_controller.dart';
import 'package:shirleys/modal/categories.dart';
import 'package:shirleys/modal/sub_category.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:shirleys/view/SearchScreen.dart';
import 'package:shirleys/view/shop_cart_screen.dart';
import 'package:shirleys/widgets/navigation_bar.dart';

import 'products_screen.dart';

class ShopScreenTab extends StatelessWidget {

  CartController cartController = Get.find();
  ShopController shopController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> DefaultTabController(
        initialIndex: shopController.currentTabIndex.value,
        length: shopController.categories.length??0,
        child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                leading: IconButton(icon: Icon(Icons.search), onPressed: () {Get.to(SearchScreen());}, color: Colors.black,),
                title: Center(child: Text('SHIRLEYS', style: TextStyle(color: Colors.black, fontSize: 20),)),
                actions: [
                  GestureDetector(
                    onTap: (){Get.to(ShopCartScreen());},
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        IconButton(icon: Icon(Icons.shopping_bag_outlined), onPressed: () {Get.to(ShopCartScreen());}, color: Colors.black),
                        Obx(() => Stack(
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
                bottom: TabBar(
                  onTap: (index){
                    print(index);
                    shopController.currentTabIndex.value = index;
                  },
                  isScrollable: true,
                  indicatorColor: AppColors.primaryColor,
                  indicatorWeight: 5.0,
                  tabs: shopController.categories.map((category) =>  Tab(
                    child: Container(
                      child: Text(category.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
//                        letterSpacing: 3,
//                        fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),).toList(),
                ),
              ),
              body:
              ModalProgressHUD(
                inAsyncCall: shopController.progressing.value,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*0.05,
                          width: double.infinity,
                          color: AppColors.primaryColor.withOpacity(0.3),
                          child: Center(
                            child: Text('GET 10% OFF FOR YOUR FIRST ORDER',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
//                              letterSpacing: 2
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.008,),
                        Image(
                          image: NetworkImage(shopController.categories[shopController.currentTabIndex.value].banner),
                          height: Get.height*0.4,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio:6/1.3,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0
                              ),
                              itemCount: shopController.categories[shopController.currentTabIndex.value].subCategories.length,
                              itemBuilder: (BuildContext ctx, index) {
                               return renderSubCategoryItem(shopController.categories[shopController.currentTabIndex.value].subCategories[index]);
                              }
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.01,),

                      ],
                    ),
                  ),
                ),
              ),
            )
      ),
    );
  }

 Widget renderSubCategoryItem(SubCategoryModal modal){

   return  GestureDetector(
     child: GestureDetector(
       onTap: () {
         Get.to(()=>ProductsScreen(subCategoryID: modal.id, pageNo: 1, title: modal.title));
       },
       child: Container(
         child: Center(
           child: new Text(
             modal.title.toUpperCase(),
             style: TextStyle(
               fontSize: 16,
//               fontFamily: 'BebasNeue',
               color: Colors.black ,
               fontWeight: FontWeight.bold,
//               letterSpacing: 2
             ),
           )
         ),
         decoration: BoxDecoration(
           border: Border.all(color: Colors.black, width: 2),
         ),
//       child: RaisedButton(
//         onPressed: () {
//           Get.to(()=>ProductsScreen(subCategoryID: modal.id, pageNo: 1));
//         },
//         color: Color(0xffc228fc),
//         child: new Text(modal.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
//
//       ),
       ),
     ),
   );
  }

}
