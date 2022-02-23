import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shirleys/controllers/auth_controller.dart';
import 'package:shirleys/controllers/shop_cart_screen_controller.dart';
import 'package:shirleys/modal/auth.dart';
import 'package:shirleys/modal/cupoun_response.dart';
import 'package:shirleys/modal/order.dart';
import 'package:shirleys/services/http_services.dart';
import 'package:shirleys/utils/AppSettings.dart';
import 'package:shirleys/widgets/my_filled_button.dart';
import 'package:shirleys/widgets/my_text_field.dart';

class OrderScreen extends StatelessWidget {
  double totalAmount;
  CupounResponse _cupounResponse = CupounResponse();
OrderScreen({this.totalAmount});
AuthController _authController = Get.find();
TextEditingController note = TextEditingController();
TextEditingController address = TextEditingController();
  TextEditingController coupon = TextEditingController();
CartController _cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    if(_authController.isLogedIn.value)
      {
        _authController.name.text = _authController.user.value.name;
        _authController.email.text = _authController.user.value.email;
        _authController.phone.text = _authController.user.value.phone;
        _authController.city.text = _authController.user.value.city;
        _authController.postCode.text = _authController.user.value.postcode;
        _authController.address.text = _authController.user.value.address;
      }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.clear), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Checkout', style: TextStyle(color: Colors.black),),
      ),
      body: _authController.progressing.value ? Center(child: CircularProgressIndicator(),): Obx(
        () => ModalProgressHUD(
          inAsyncCall: _authController.progressing.value,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Row(
                //   children: [
                //     SizedBox(width: Get.width*0.03,),
                //     Text('Shirleys\t\t\t', style: TextStyle(color: Colors.black, fontSize: 25),),
                //     IconButton(icon: Icon(Icons.lock,), onPressed: () {}),
                //     Text('Secure Checkout', style: TextStyle(color: Colors.black,fontSize: 12),),
                //   ],
                // ),
                SizedBox(height: 10,),
                _authController.isLogedIn.value ? Container(): Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Container(
                  height: 405,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5,),
                        Center(child: Text('Your Details', style: TextStyle(color: Colors.black,fontSize: 16),),),
                        Divider(),
                        SizedBox(height: 10,),
                        Text('Name*', style: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26)
                          ),
                          child: Center(
                            child: TextField(
                              controller: _authController.name,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: '',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 13,),
                        Text('Email Address*', style: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26)
                          ),
                          child: Center(
                            child: TextField(
                              controller: _authController.email,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: '',
//                              focusColor:
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 13,),
                        Text('Mobile Number*', style: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26)
                          ),
                          child: Center(
                            child: TextField(
                              controller: _authController.phone,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: '',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 13,),
                        Text('City*', style: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26)
                          ),
                          child: Center(
                            child: TextField(
                              controller: _authController.city,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: '',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                  child: Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5,),
                          Center(child: Text('Billing Address', style: TextStyle(color: Colors.black,fontSize: 16),),),
                          Divider(),
                          SizedBox(height: 10,),
                          Text('Address*', style: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26)
                            ),
                            child: TextField(
                              controller: _authController.address,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text('Note*', style: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height*0.17,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26)
                            ),
                            child: TextField(
                              controller: note,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              minLines: 1,
                              maxLines: 5,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5,),
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
//              child: Container(
//                height: MediaQuery.of(context).size.height*0.1,
//                width: double.infinity,
//                decoration: BoxDecoration(
//                    border: Border.all(color: Color(0xffc228fc),)
//                ),
//                child: Padding(
//                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: [
//                      Icon(Icons.favorite_sharp, color: Color(0xffc228fc),),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Text('Home Delivery', style: TextStyle(fontSize: 18),),
//                          Text('Standar Tracked Delivery \$2.99', style: TextStyle(color: Colors.black54, fontSize: 14),),
//                          Text('Delivery in 3-5 days', style: TextStyle(color: Colors.black54, fontSize: 14),),
//                        ],
//                      ),
//                      Icon(Icons.arrow_forward_ios,color: Color(0xffc228fc),)
//                    ],
//                  ),
//                ),
//              ),
//            ),
//                Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
//                  child: Container(
//                    height: MediaQuery.of(context).size.height*0.1,
//                    width: double.infinity,
//                    decoration: BoxDecoration(
//                        border: Border.all(color: Colors.black54)
//                    ),
//                    child: Padding(
//                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                      child: Column(
//                        children: [
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: [
//                              Text('Item Total: 1 item', style: TextStyle(color: Colors.black, fontSize: 14),),
//                              Text('\$21.99', style: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),),
//                            ],
//                          ),
//                          SizedBox(height: 5,),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: [
//                              Text('Delivery', style: TextStyle(color: Colors.black, fontSize: 14),),
//                              Text('\$2.99', style: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),),
//                            ],
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.05,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54)
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Amount: ', style: TextStyle(color: Colors.black, fontSize: 14),),
                              Text('\$${totalAmount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyTextField(controller: coupon, label: "Enter Coupon Code",width: (Get.width-20)*0.57,),
                      SizedBox(width: (Get.width-20)*0.01,),
                      GestureDetector(
                        onTap: () async {
                        if(coupon.text.length>0){
                          _authController.progressing.value = true;
                          _cupounResponse = await HttpService.getDiscount(coupon.text, totalAmount.toString());
                          _authController.progressing.value = false;
                          // Fluttertoast.showToast(msg: _cupounRespone.msg);
                          Get.snackbar(_cupounResponse.status, _cupounResponse.msg,duration: Duration(seconds: 3));
                        }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: 45,
                          width: (Get.width-20)*0.40,
                          child: Center(
                              child: Text('Get Discount',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
//                            letterSpacing: 2,
//                            fontFamily: 'BebasNeue',
                                ),
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
                  child: GestureDetector(
                    onTap: () async {
                      if(placeOrderValidation()){
                        _authController.progressing.value = true;
                        OrderResponse orderResponse = await HttpService.placeOrder(
                            isLoggedIn: _authController.isLogedIn.value,
                            cupounId: _cupounResponse.couponId,
                            user: User(name: _authController.name.text,
                                email: _authController.email.text,
                                phone: _authController.phone.text,
                                city: _authController.city.text,
                                postcode: _authController.postCode.text,
                                address: _authController.address.text,
                                id:  _authController.user.value == null ? "" : _authController.user.value.id
                            ),
                            orderNote: note.text,
                            billingAddress: address.text,
                            orderDetail: OrderDetail(_cartController.items)
                        );
                        _authController.progressing.value = false;
                        if(_authController.user.value == null){
                          if(orderResponse.customerStatus == 'failed'){
                            Fluttertoast.showToast(msg: 'Email is already taken');
                            return false;
                          }
                        }
                        if(orderResponse.orderStatus=="success") {
                          Get.back();
                          _cartController.clearCart();
                        }
                        Fluttertoast.showToast(msg: orderResponse.msg);
                      }
//
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 40,
                      width: double.infinity,
                      child: Center(
                        child: Text('Confirm Order',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
//                            letterSpacing: 2,
//                            fontFamily: 'BebasNeue',
                          ),
                        )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
                  child: GestureDetector(
                    onTap: () {Get.back();},
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[350],
                      ),
                      child: Center(
                        child: Text('Back',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
//                            letterSpacing: 2,
//                            fontFamily: 'BebasNeue',
                          ),
                        )
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
  bool placeOrderValidation() {
    if
    (_authController.name.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Name is Required');
      return false;
    }
    else if(_authController.email.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is Required');
      return false;
    }
    else if
    (!GetUtils.isEmail(_authController.email.text)){
      Fluttertoast.showToast(msg: 'Email format is not correct');
      return false;
    }
    else if(_authController.phone.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Phone is Required');
      return false;
    }
    else if(_authController.city.text.trim().length==0){
      Fluttertoast.showToast(msg: 'City is Required');
      return false;
    }
    else if(_authController.address.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Address is Required');
      return false;
    }
    else
      return true;
  }
}
