import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingContainer extends StatelessWidget {
  bool progressing;
  LoadingContainer(this.progressing);
  @override
  Widget build(BuildContext context) {
    return progressing? Container(
      color: Colors.grey.withOpacity(0.5),
      height: Get.height,
      width: Get.width,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ):
    Container();
  }
}