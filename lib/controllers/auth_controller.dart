import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shirleys/modal/ForgotPassword.dart';
import 'package:shirleys/modal/auth.dart';
import 'package:shirleys/services/http_services.dart';
import 'package:shirleys/view/account%20views/account_screen.dart';
import 'package:shirleys/view/homepage.dart';
import 'package:shirleys/view/order_screen.dart';

class AuthController extends GetxController{
  Rx<User> user= User().obs;
  RxBool isLogedIn = false.obs;
  RxBool progressing = false.obs;
  RxBool checkBoxValue = false.obs;


  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController postCode = TextEditingController();
  TextEditingController city = TextEditingController();


  @override
  Future<void> onInit() async {
    user.value =await User.fromCache();
    isLogedIn.value = user.value==null?false : true;
    // TODO: implement onInit
    super.onInit();
  }


  bool loginValidation(){
    if(email.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }
    if
    (password.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Password is required');
      return false;
    }
    else if
    (!GetUtils.isEmail(email.text)){
      Fluttertoast.showToast(msg: 'Email format is not correct');
      return false;
    }
    else
      return true;
  }

  bool forgotPasswordValidation() {
    if(email.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }
    else if
    (!GetUtils.isEmail(email.text)){
      Fluttertoast.showToast(msg: 'Email format is not correct');
      return false;
    }
    else
      return true;
  }


  bool registerValidation(){
    if(name.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Name is Required');
      return false;
    }else if
    (email.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }else if
    (password.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Password is required');
      return false;
    }else if
    (phone.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Phone Number is required');
      return false;
    }else if
    (address.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Address is required');
      return false;
    }else if
    (postCode.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Post Code is required');
      return false;
    }else if
    (city.text.trim().length==0){
      Fluttertoast.showToast(msg: 'City is required');
      return false;
    }
    else
      return true;
  }
  void login() async {
    if(loginValidation()){
      progressing.value = true;
      AuthResponse response = await HttpService.loginUser(
          email.text,
          password.text
      );
      progressing.value = false;
      if(response.user==null){
        Fluttertoast.showToast(msg: response.msg);
      }
      else
      {
        this.password.clear();
        this.email.clear();
        User.saveUserToCache(response.user);
        user.value = response.user;
        isLogedIn.value = true;
        Get.off(AccountScreen());

      }
    }
  }

  logOut(){
    user.value = null;
    User.deleteCachedUser();
    isLogedIn.value = false;
  }
  void register(bool returnToOrderScreen)async {
    if(registerValidation()){
      progressing.value = true;
      AuthResponse response = await HttpService.registerUser(
          name.text,
          email.text,
          password.text,
          phone.text,
          address.text,
          postCode.text,
          city.text
      );
      progressing.value = false;
      if(response.user==null){
        Fluttertoast.showToast(msg: response.msg);
      }
      else
      {
        this.name.clear();
        this.email.clear();
        this.password.clear();
        this.phone.clear();
        this.address.clear();
        this.postCode.clear();
        this.city.clear();
        User.saveUserToCache(response.user);
        this.user.value = response.user;
        this.isLogedIn.value = true;
        Get.to(returnToOrderScreen?OrderScreen():HomePage());
      }
    }
  }

  void forgotPassword() async {
    if(forgotPasswordValidation()){
      progressing.value = true;
      ForgotPasswordResponse response = await HttpService.forgotPassword(
          email.text,
      );
      progressing.value = false;
      if(response!=null){
        Fluttertoast.showToast(msg: response.msg);
      }
      else
      {
        Get.back();
      }
    }
  }

  updateUser(User updatedUSer){
    this.user.value = updatedUSer;
    User.saveUserToCache(updatedUSer);
  }



//  void updateProfile() async {
//    progressing.value = true;
//    String response = await HttpService.updateProfile();
//    progressing.value = false;
//    if(response==null){
//      Fluttertoast.showToast(msg: response.msg);
//    }
//    else
//    {
//      this.name.clear();
//      this.email.clear();
//      User.saveUserToCache(response.user);
//      user.value = response.user;
//      isLogedIn.value = true;
//      Get.off(OrderScreen());
//
//    }
//  }





}