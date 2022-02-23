import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shirleys/controllers/auth_controller.dart';
import 'package:shirleys/controllers/review_controller.dart';
import 'package:shirleys/modal/add_review.dart';
import 'package:shirleys/modal/auth.dart';
import 'package:shirleys/services/http_services.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:shirleys/widgets/image_pick_widget.dart';
import 'package:shirleys/widgets/loading_container.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class InputReviewScreen extends StatelessWidget {


  InputReviewScreen({@required this.productId});
  TextEditingController remarks = TextEditingController();
  RxBool progressing = false.obs;
  AuthController authController = Get.find();
  var rating = 0.0;
  File file;
  String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Rate this Product', style: TextStyle(color: Colors.black,),),
      ),
      body:  Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyImagePicker(file),
                  Divider(),
                  SizedBox(height: 10,),
                  Text('Rating', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  SizedBox(height: Get.height*0.008,),
                  SmoothStarRating(
                    onRated: (rate){
                      print(rate);
                      rating = rate;
                    },
                    allowHalfRating: false,
                    color: AppColors.primaryColor,
//                rating: 4.5,
                    size: 35,
                  ),
                  Divider(),
                  SizedBox(height: 10,),
                  Text('Remarks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  SizedBox(height: Get.height*0.008,),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.2,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26)
                    ),
                    child: TextField(
                      controller: remarks,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Remarks',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () async{
                      progressing.value = true;
                      AddReview  response = await  HttpService.addReview(customerId:authController.user.value.id,productId: productId,rating: rating.toString(),remarks: remarks.text,photo: file!=null?"":"");
                      progressing.value = false;
                      if(response.status=='already_submitted'){
                        Fluttertoast.showToast(msg: response.msg);
                      }else {
                        Fluttertoast.showToast(msg: response.msg);
                      }
                      Get.back();
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor,
                      ),
                      child: Center(child:Text('Submit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(()=>LoadingContainer(progressing.value))
        ],
      ),
    );
  }
}
