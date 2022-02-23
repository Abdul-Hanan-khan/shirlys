import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shirleys/controllers/auth_controller.dart';
import 'package:shirleys/utils/AppSettings.dart';

class ForgotPasswordScreen extends StatelessWidget {
  AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Forgot Password', style: TextStyle(color: Colors.black,),),
      ),
      body: controller.progressing.value ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                obscureText: false,
                controller: controller.email,
                cursorColor: AppColors.primaryColor,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: () {
                  controller.forgotPassword();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 40,
                  width: double.infinity,
                  child: Center(child: Text('Send Password', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),)),
                ),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: () {Get.back();},
                child: Center(
                  child: Text(
                    'Back to Login',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
