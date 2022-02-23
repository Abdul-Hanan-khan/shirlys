import 'package:flutter/material.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:shirleys/utils/styles.dart';

class MyLabel extends StatelessWidget {
  bool   borderWidth;
  String label;
  Color  backGroundColor;
  Color  textColor;
  double borderRadius;
  double height;
  double width;
  double fontSize;

  GestureTapCallback onTap;
  MyLabel({
  @required this.label,
      this.onTap,
      this.borderWidth,
      this.backGroundColor,
      this.textColor,
      this.borderRadius,
      this.width,
      this.height,
      this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 3),
              decoration: BoxDecoration(
            color: backGroundColor??AppColors.primaryColor,
            borderRadius: BorderRadius.circular(borderRadius??0),
          ),
            child: Center(child: Text(label,style: Styles.labelTextStyle().copyWith(
              color: textColor??Colors.white,
              fontSize: fontSize??10,
            ))),
          ),
        ),
      ],
    );
  }
}
