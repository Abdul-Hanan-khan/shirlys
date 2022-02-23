import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shirleys/modal/featured_products_model.dart';
import 'package:shirleys/modal/products.dart';
import 'package:shirleys/services/http_services.dart';

class FeaturedProductController extends GetxController{
  String subCategoryID;
  int pageNo;
  FeaturedProductController()
  {
    loadProducts();
  }
  var productsModal = FeaturedProducts(products: [],totalPages: 0).obs;


  loadProducts() async {
    this.productsModal.value = await HttpService.getFeaturedProductsOfSubCategory();
  }
  loadMoreProducts(String subCategoryID,int pageNo) async {
    FeaturedProducts rawModal = await  HttpService.getFeaturedProductsOfSubCategory();
    productsModal.value.products.addAll(rawModal.products);
  }

}