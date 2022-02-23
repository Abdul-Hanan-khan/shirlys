import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:shirleys/utils/styles.dart';

class MyTextField extends StatelessWidget {
  TextEditingController controller;
  String label;
  bool obsecureText =false;
  IconButton suffixIcon;
  final ValueChanged<String> onChanged;
  Function onEditingComplete;
  GestureTapCallback onTap;
  bool enabled=true;
  int maxLines;
  String hintText;
  TextInputType keyboardType;
  bool autoFocus;
  double height;
  double width;
  ///Constructor
  MyTextField({
    @required this.controller,
    @required this.label,
    this.obsecureText,
    this.onChanged,
    this.suffixIcon,
    this.onEditingComplete,
    this.enabled,
    this.onTap,
    this.maxLines,
    this.hintText,
    this.keyboardType,
    this.autoFocus,
    this.height,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    bool _passwordVisible = false;
    return Container(
      height: height??45,
      width: width??double.infinity,
      child: GestureDetector(
        onTap: onTap,
        child: TextField(
          autofocus: autoFocus??false,
          keyboardType: keyboardType,
          maxLines: maxLines??1,
          enabled: enabled,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          onChanged:onChanged,
          controller: controller,
          obscureText: obsecureText??false,
          cursorColor: AppColors.primaryColor,
          style: Styles.textFieldTextStyle(),
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            fillColor: AppColors.primaryColor,
              focusColor: AppColors.primaryColor,
              hoverColor: AppColors.primaryColor,
              labelText: label,
              hintStyle:TextStyle(
                color: Colors.black54,
                fontSize: 12
              ),
              labelStyle: TextStyle(
                color: AppColors.primaryColor
              ),
              disabledBorder:OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.primaryColor
                  )
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.primaryColor
                  )
              ),
              focusedBorder:  OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.primaryColor
                  )
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primaryColor
                )
              ),
              // hintText: label,
          ),
        ),
      ),
    );
  }
}
