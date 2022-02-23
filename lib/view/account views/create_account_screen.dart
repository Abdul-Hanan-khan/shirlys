import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shirleys/controllers/auth_controller.dart';
import 'package:shirleys/modal/auth.dart';
import 'package:shirleys/services/http_services.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:shirleys/view/homepage.dart';
import 'package:shirleys/view/order_screen.dart';
import 'sign_in_screen.dart';
import 'package:shirleys/widgets/my_text_field.dart';

class CreateAccountScreen extends StatelessWidget {
  AuthController controller = Get.find();
  bool returnToOrderScreen;
  CreateAccountScreen({this.returnToOrderScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Create Account', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
        ()=> ModalProgressHUD(
          inAsyncCall: controller.progressing.value,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildTextField(text: 'Name',controller: controller.name, obscureText: false),
                  SizedBox(height: 3,),
                  buildTextField(text:'Email', controller: controller.email, obscureText: false),
                 returnToOrderScreen?Container(): SizedBox(height: 3,),
                  returnToOrderScreen?Container():  buildTextField(text: 'Password', controller: controller.password, obscureText: true),
                  SizedBox(height: 3,),
                  buildTextField(text: 'Phone', controller: controller.phone, obscureText: false),
                  SizedBox(height: 3,),
                  buildTextField(text: 'Address', controller: controller.address, obscureText: false),
                  SizedBox(height: 3,),
                  buildTextField(text: 'Post Code', controller: controller.postCode, obscureText: false),
                  SizedBox(height: 3,),
                  buildTextField(text: 'City', controller: controller.city, obscureText: false),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      controller.register(returnToOrderScreen);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 40,
                      width: double.infinity,
                      child: Center(child:
                        Text(returnToOrderScreen?'Next':'Register',
                          style: TextStyle(
//                            letterSpacing: 2,
//                            fontFamily: 'BebasNeue',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {Get.off(SignInScreen(returnToOrderScreen:returnToOrderScreen));},
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 40,
                      width: double.infinity,
                      child: Center(child:
                        Text('Already Have An Account', style: TextStyle(
//                            letterSpacing: 2,
//                            fontFamily: 'BebasNeue',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  TextFormField buildTextField({String text, TextEditingController controller,bool obscureText}) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        labelText: text,
      ),
    );
  }



}
