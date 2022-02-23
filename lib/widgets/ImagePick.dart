



import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePick extends StatelessWidget {
  String imageUrl;
  ImagePick({
    Key key,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(imageUrl),
      height: Get.height*0.4,
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }
}
