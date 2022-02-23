import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shirleys/controllers/auth_controller.dart';
import 'package:shirleys/modal/auth.dart';
import 'package:shirleys/modal/update_profile.dart';
import 'package:shirleys/services/http_services.dart';
import 'package:shirleys/utils/AppSettings.dart';

class AccountDetailScreen extends StatelessWidget {
  AuthController controller = Get.find();
  TextEditingController email ;
  TextEditingController name   ;
  TextEditingController phone ;
  TextEditingController address ;
  TextEditingController postCode ;
  TextEditingController city ;
  TextEditingController oldPassword ;
  TextEditingController newPassword ;

  AccountDetailScreen(){
    email = TextEditingController(text: controller.user.value.email);
    name   = TextEditingController(text: controller.user.value.name);
    phone = TextEditingController(text: controller.user.value.phone);
    address = TextEditingController(text: controller.user.value.address);
    postCode = TextEditingController(text: controller.user.value.postcode);
    city = TextEditingController(text: controller.user.value.city);
    oldPassword = TextEditingController();
    newPassword = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    RxBool progressing = false.obs;


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Update Profile', style: TextStyle(color: Colors.black,),),
      ),
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: progressing.value,
          child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      hintText: controller.user.value.name,
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                   labelText: 'Email',
                      hintText: controller.user.value.email,
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: phone,
                    decoration: InputDecoration(
                      hintText: controller.user.value.phone,
                   labelText: 'Phone',
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: address,
                    decoration: InputDecoration(
                      hintText: controller.user.value.address,
                   labelText: 'Address',
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: postCode,
                    decoration: InputDecoration(
                      hintText: controller.user.value.postcode,
                   labelText: 'Post Code',
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: city,
                    decoration: InputDecoration(
                      hintText: controller.user.value.city,
                   labelText: 'City',
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                     Checkbox(
                        value: controller.checkBoxValue.value,
                        activeColor: AppColors.primaryColor,
                        onChanged: (val) {controller.checkBoxValue.value=val;},
                      ),
                      Text('Update Password', style: TextStyle(fontSize: 16),),
                    ],
                  ),SizedBox(height: 5,),
                  controller.checkBoxValue.value
                      ? Column(
                    children: [
                      TextFormField(
                        controller: oldPassword,
                        decoration: InputDecoration(
                          labelText: 'Old Password',
                        ),
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: newPassword,
                        decoration: InputDecoration(
                          labelText: 'New Password',
                        ),
                      ),
                    ],
                  )
                      : Container(),
                  SizedBox(height: 5,),
                  Divider(color: Colors.grey,),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () async {
                      if(updateProfileValidation()==true){
                        progressing.value = true;
                        UpdateProfileResponse response = await HttpService.updateProfile(address: address.text, phone: phone.text, email: email.text, name: name.text, city: city.text, customerId: controller.user.value.id, postCode: postCode.text, updatePassword: controller.checkBoxValue.value,newPassword: newPassword.text??"");
                        progressing.value = false;
                        Fluttertoast.showToast(msg: response.msg.toString());
                        if(response.status=="success")
                          {
                            controller.updateUser(User(
                              name: name.text,
                              email: email.text,
                                password: controller.checkBoxValue.value? newPassword.text:controller.user.value.password,
                                phone: phone.text,
                                address:address.text,
                                postcode:postCode.text,
                                city:city.text,
                                id:controller.user.value.id,
                            ));
                            Get.back();
                          }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 40,
                      width: double.infinity,
                      child: Center(child: Text('UPDATE ACCOUNT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)),
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
          ),
        ),
            ),
      ),
    );
  }

  bool updateProfileValidation() {
    if
    (name.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Name is Required');
      return false;
    }
    else if(email.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is Required');
      return false;
    }
    else if
    (!GetUtils.isEmail(email.text)){
      Fluttertoast.showToast(msg: 'Email format is not correct');
      return false;
    }
    else if
    (phone.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Phone Number is Required');
      return false;
    }
    else if
    (address.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Address is Required');
      return false;
    }
    else if
    (postCode.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Post Code is Required');
      return false;
    }
    else if
    (city.text.trim().length==0){
      Fluttertoast.showToast(msg: 'City Name is Required');
      return false;
    }
    else
      return true;
  }
}
