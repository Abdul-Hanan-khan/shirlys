import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirleys/controllers/search_product_controller.dart';
import 'package:shirleys/view/product_detail_screen.dart';
import 'package:shirleys/view/products_screen.dart';

class SearchScreen extends StatelessWidget {


  TextEditingController search = TextEditingController();
  SearchProductController controller = SearchProductController();
  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.clear), onPressed: () {Get.back();}, color: Colors.black,),
          leadingWidth: 25,
          title: Container(
            alignment: Alignment.centerLeft,
            color: Colors.white,
            width: double.infinity,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Product',
              ),
              onChanged: (value) {
                if(value.length==0)
                  controller.clearSearches();
                else
                controller.loadSearchProduct(value);
              },
            ),
          ),
        ),
        body: controller.searchedProducts.length==0? Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_outlined, size: 60, color: Colors.black38,),
              Text('No Results Found', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),textAlign: TextAlign.center,),
              Text('Your search will appear here.',style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
              //),
              // listItem(1),
            ],
          ),
        ):
          ListView(
            children: controller.searchedProducts.value.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: GestureDetector(
                  onTap: (){
                    Get.to(()=> ProductsScreen(subCategoryID: item.subCategoryId, pageNo: 0, title: item.subCategoryTitle));
                  },
                  child: Container(
                    color: Colors.grey[100],
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 8),
                      child: Text(item.title, style: TextStyle(fontSize: 16, letterSpacing: 1),),
                    ),
                  ),
                ),
              );
            }).toList()
          ),
      ),
    );
  }
}
