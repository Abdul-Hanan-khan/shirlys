import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shirleys/modal/auth.dart';
import 'package:shirleys/modal/review.dart';
import 'package:shirleys/services/http_services.dart';

class ReviewScreenController extends GetxController{
  String productId;
  ReviewScreenController({@required this.productId})
  {
    loadReviews();
  }
  RxBool loading = true.obs;
  List<Review> reviews =[];



  loadReviews() async{
    reviews = await HttpService.getReview(productId);
    loading.value = false;
  }


}