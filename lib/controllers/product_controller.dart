import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shirleys/modal/products.dart';
import 'package:shirleys/services/http_services.dart';

class ProductController extends GetxController{
  String subCategoryID;
  int pageNo;
  ProductController({@required this.subCategoryID,@required this.pageNo})
  {
    loadProducts();
  }
  var productsModal = ProductsModal(products: [],totalPages: 0).obs;


  loadProducts() async {
    this.productsModal.value = await HttpService.getProductsOfSubCategory(subCategoryID, pageNo);
  }
  loadMoreProducts(String subCategoryID,int pageNo) async {
    ProductsModal rawModal = await  HttpService.getProductsOfSubCategory(subCategoryID, pageNo);
    productsModal.value.products.addAll(rawModal.products);
  }

}