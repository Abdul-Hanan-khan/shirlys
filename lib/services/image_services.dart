// import 'dart:convert';

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class ImageServices{



  static Future<String> encodeImageTObase64(File file) async{
    // Image image= Image();

    // final bytes = await Io.File(image).readAsBytesSync();
    final bytes = await file.readAsBytes();
    return  base64.encode(bytes);
  }

  // static decodeBase64toImageFile(){
  //
  //
  // }
  static Future<Image> decodeBase64ToImage(String base64String) async {
    var bytes = base64.decode(base64String);
    Image image = Image.memory(bytes) ;
    return image;
  }




}