import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shirleys/controllers/auth_controller.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'forgot_password_screen.dart';

class SignInScreen extends StatelessWidget {
  bool returnToOrderScreen;
  SignInScreen({this.returnToOrderScreen});
  AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Sign In', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
          () => controller.progressing.value ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
          child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.email,

                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: 3,),
                    TextFormField(
                      controller: controller.password,
                      obscureText: true,
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 15,),
                    Divider(),
                    SizedBox(height: 15,),
                    GestureDetector(
                      onTap: (){
                        controller.login();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 40,
                        width: double.infinity,
                        child: Center(
                          child: Text('Log in',
                            style: TextStyle(
//                              letterSpacing: 2,
//                              fontFamily: 'BebasNeue',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: GestureDetector(
                        onTap: () {Get.to(ForgotPasswordScreen());},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontSize: 16
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


        ),
      ),
    );
  }
}
