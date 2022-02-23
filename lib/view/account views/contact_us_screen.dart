import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shirleys/controllers/auth_controller.dart';
import 'package:shirleys/services/http_services.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:shirleys/view/home_tab.dart';

import '../shop_cart_screen.dart';

class ContactUsScreen extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController instaUrl = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();
  AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Contact US',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: Obx(
          () => controller.progressing.value ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                buildTextField(text: 'Name', controller: name, obscureText: false),
                buildTextField(text: 'Email', controller: email, obscureText: false),
                buildTextField(text: 'Instagram Url', controller: instaUrl, obscureText: false),
                buildTextField(text: 'Subject', controller: subject, obscureText: false),
                SizedBox(height: 5,),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.17,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26)
                  ),
                  child: TextField(
                    controller: message,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Message',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Divider(),
                SizedBox(height: 5,),
                GestureDetector(
                  onTap: () async {
                    if(contactUsValidation()){
                      controller.progressing.value = true;
                      String msg = await HttpService.contactUs(
                        email: email.text,
                        name: name.text,
                        subject: subject.text,
                        message: message.text,
                        instaUrl: instaUrl.text
                      );
                      controller.progressing.value = false;
                      Fluttertoast.showToast(msg: msg);
                      Get.back();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 40,
                    width: double.infinity,
                    child: Center(child:
                    Text('Submit', style: TextStyle(
//                            letterSpacing: 2,
//                            fontFamily: 'BebasNeue',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
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

  bool contactUsValidation(){
    if(name.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Name is Required');
      return false;
    }else if
    (email.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }else if
    (subject.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Post Code is required');
      return false;
    }else if
    (message.text.trim().length==0){
      Fluttertoast.showToast(msg: 'City is required');
      return false;
    }
    else
      return true;
  }

}
