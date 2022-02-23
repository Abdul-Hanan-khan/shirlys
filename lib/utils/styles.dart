import 'package:flutter/material.dart';

import 'AppSettings.dart';

class Styles{

  static TextStyle textFieldlabelTextStyle(){
    return TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: AppColors.primaryColor2
    );
  }
  static TextStyle textFieldTextStyle(){
    return TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: AppColors.dark
    );
  }
  static TextStyle labelTextStyle(){
    return TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor2
    );
  }
  static TextStyle homeScreenListItemTextStyle(){
    TextStyle(
        color: Colors.blue[700],
        fontSize: 15,
        fontWeight: FontWeight.bold
    );
  }

}
