import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:shirleys/modal/html_content.dart';
import 'package:shirleys/services/http_services.dart';
import 'package:shirleys/view/home_tab.dart';
import 'package:shirleys/view/shop_cart_screen.dart';

class HtmlViewer extends StatefulWidget {
  String pageID;
  HtmlViewer(this.pageID);
  @override
  _HtmlViewerState createState() => _HtmlViewerState();
}

class _HtmlViewerState extends State<HtmlViewer> {
  bool isLoading = true;
  HtmlContent content = HtmlContent();
  @override
  void initState() {
 loadModal();
// TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text(content.title??"",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
//            letterSpacing: 2
          ),
        ),
        actions: [
        ],
      ),
      body: isLoading? Center(child: CircularProgressIndicator(),):
      SingleChildScrollView(
        child: Html(

          data: content.content,
        ),
      ),
    );
  }
  loadModal()async{
    content = await HttpService.htmlContent(widget.pageID);
    print(content);
    setState(() {
      isLoading=false;
    });

  }
}
