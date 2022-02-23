import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirleys/view/homepage.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 2)).then((value) => Get.off(HomePage()));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: double.infinity,
        color: Color(0xfff0d6fa),
        child: Center(
          child: Image.asset('assets/image/logo.png', scale: 2,),
        ),
      ),
    );
  }
}