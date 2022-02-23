import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirleys/utils/AppSettings.dart';

class AlertDialogWidget extends StatelessWidget {
  String title;
  String subTitle;
  GestureTapCallback onPositiveClick;

  AlertDialogWidget({this.title, this.subTitle, this.onPositiveClick});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
//                                                        letterSpacing: 1,
        ),
      ),
      content: Text(subTitle,
        style: TextStyle(
//                                                        letterSpacing: 1,
        ),
      ),
      actions: [
        TextButton(
          child: Text(
              'No',
              style: TextStyle(
                  fontSize: 16,
//                                                            letterSpacing: 1,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold)
          ),
          onPressed: (){Get.back();},
        ),
        TextButton(
            child: Text(
              'Yes',
              style: TextStyle(
//                                                            letterSpacing: 1,
                  fontSize: 16,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: onPositiveClick
        ),
      ],
    );
  }
}