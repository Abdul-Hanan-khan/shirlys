import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirleys/controllers/review_controller.dart';
import 'package:shirleys/modal/review.dart';
import 'package:shirleys/services/http_services.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewsScreen extends StatelessWidget {
String productId;
 ReviewsScreen({@required this.productId});
  @override
  Widget build(BuildContext context) {
    ReviewScreenController controller = ReviewScreenController(productId: productId);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Reviews', style: TextStyle(color: Colors.black,),),
      ),
      body: Obx(
        ()=> controller.loading.value? Center(child: CircularProgressIndicator(),):
        controller.reviews.length == 0
            ? Center(child: Text('There is No Review', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),)
        : ListView(
          children: controller.reviews.map((review) =>renderListItem(review)).toList(),
        )
      ),
    );
  }
  Widget renderListItem(Review review){

    return Container(
      width: double.infinity,
//      height: Get.height*0.,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('${review.name}\t', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SmoothStarRating(
                    rating: double.parse(review.rating),
                    size: 15,
                    color: AppColors.primaryColor
                ),
              ],
            ),
            Text(review.createdDate, style: TextStyle(fontSize: 14)),
            SizedBox(height: 11,),
            Text(review.remarks, style: TextStyle(fontSize: 14)),
            SizedBox(height: 11,),
            review.photo.length == 0 ? Container() : Container(
              width: Get.width*0.4,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(review.photo),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
