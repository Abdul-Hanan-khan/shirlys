import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirleys/modal/categories.dart';
import 'package:shirleys/modal/sub_category.dart';
import 'package:shirleys/services/http_services.dart';

class ShopController extends GetxController{
  RxInt currentTabIndex = 0.obs;
  RxList<CategoryModal> categoriesHome = <CategoryModal>[].obs;
  RxList<CategoryModal> categories = <CategoryModal>[].obs;
  RxBool progressing = false.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() async{
    categoriesHome.value = await HttpService.getHomeCategories();
    categories.value = await HttpService.getAllCategories();
    isLoading.value = false;
    super.onInit();
  }

}