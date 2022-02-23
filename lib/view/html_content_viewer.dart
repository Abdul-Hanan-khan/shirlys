import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:shirleys/modal/html_content.dart';
import 'package:shirleys/services/http_services.dart';
import 'package:shirleys/view/home_tab.dart';
import 'package:shirleys/view/shop_cart_screen.dart';

class HtmlContentViewer extends StatelessWidget {
  String  appBarTitle;
  String content;
   HtmlContentViewer(this.appBarTitle,this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text(appBarTitle??"",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
//            letterSpacing: 2
          ),
        ),
        actions: [
        ],
      ),
      body:
      Html(
        data: content??"",
      ),
    );
  }
}
