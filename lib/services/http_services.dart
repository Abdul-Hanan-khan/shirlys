import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shirleys/modal/ForgotPassword.dart';
import 'package:shirleys/modal/add_review.dart';
import 'package:shirleys/modal/cart_modal.dart';
import 'package:shirleys/modal/categories.dart';
import 'package:shirleys/modal/cupoun_response.dart';
import 'package:shirleys/modal/featured_products_model.dart';
import 'package:shirleys/modal/html_content.dart';
import 'package:shirleys/modal/order_history.dart';
import 'package:shirleys/modal/order.dart';
import 'package:shirleys/modal/product_gallary.dart';
import 'package:shirleys/modal/products.dart';
import 'package:shirleys/modal/review.dart';
import 'package:shirleys/modal/search.dart';
import 'package:shirleys/modal/auth.dart';
import 'package:shirleys/modal/update_profile.dart';

class HttpService {
  static Uri _uri = Uri.parse("https://shirleysofficial.com/app/app.php");

  static Future<List<CategoryModal>> getAllCategories() async {
    try {
      var response = await http.post(
        _uri,
        body: {'get_all_categories': '1'},
      );
      if (response.statusCode == 200) {
        List rawList = jsonDecode(response.body);
        return rawList.map((json) => CategoryModal.fromJson(json)).toList();
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }
  static Future<List<CategoryModal>> getHomeCategories() async {
    try {
      var response = await http.post(
        _uri,
        body: {'get_homepage_categories': '1'},
      );
      if (response.statusCode == 200) {
        List rawList = jsonDecode(response.body);
        return rawList.map((json) => CategoryModal.fromJson(json)).toList();
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  // static Future<List<SubCategoryModal>> getSubCategoriesOfCategory(
  //      String categoryID) async {
  //    try {
  //      var response = await http.post(
  //        _uri,
  //        body: {
  //          'get_sub_categories': '1',
  //          'category_id': categoryID,
  //        },
  //      );
  //      if (response.statusCode == 200) {
  //        List rawList = jsonDecode(response.body);
  //        return rawList.map((json) => SubCategoryModal.fromJson(json)).toList();
  //      } else
  //        return null;
  //    } catch (e) {
  //      return null;
  //    }
  //  }

  /// product related APIS
  static Future<ProductsModal> getProductsOfSubCategory(
      String subCategoryID,int pageNo) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'sub_category_products': '1',
          'sub_category_id': subCategoryID,
          'page_no': pageNo.toString()
        },
      );
      if (response.statusCode == 200) {
        return ProductsModal.fromJson(jsonDecode(response.body)) ;

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }
  static Future<FeaturedProducts> getFeaturedProductsOfSubCategory() async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'featured_products': '1',

        },
      );
      if (response.statusCode == 200) {
        return FeaturedProducts.fromJson(jsonDecode(response.body)) ;

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<ProductGalleryModal> getProductGallery(
      String productID,String choiceID) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'choice_gallery': '1',
          'product_id': productID,
          'choice_id': choiceID
        },
      );
      if (response.statusCode == 200) {
        response.body;
        List rawList = jsonDecode(response.body);
        return ProductGalleryModal(galleryItems: rawList.map((json) => GalleryItem.fromJson(json)).toList());
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<List<ProductsModal>> searchProducts(
      String searchString,int pageNo) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'search_string': searchString,
          'page_no': pageNo.toString()
        },
      );
      if (response.statusCode == 200) {
        List rawList = jsonDecode(response.body);
        return rawList.map((json) => ProductsModal.fromJson(json));
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  /// order Apis

  static Future<OrderResponse> placeOrder
      ({User user,@required bool isLoggedIn,@required String orderNote, @required String billingAddress, @required OrderDetail orderDetail,String cupounId}) async {
    try {
      double totalAmount = 0;
      orderDetail.orderItems.forEach((element) {
        totalAmount = totalAmount+element.totalAmount;
      });
      List<dynamic> _orderDetails = orderDetail.orderItems.map((orderItem) => orderItem.toJson()).toList();

      Map<String ,String>  body = {
        'new_order' : '1',
        'customer_type' : isLoggedIn ? 'login' : 'guest',
        'customer_id' : isLoggedIn?user.id:"",
        'name': !isLoggedIn?user.name:"",
        'email': !isLoggedIn?user.email:"",
        'phone': !isLoggedIn?user.phone:"",
        'city': !isLoggedIn?user.city:"",
        'postcode': !isLoggedIn?user.postcode:"",
        'address': !isLoggedIn?user.address:"",
        'order_notes' : orderNote,
        'billing_address' : billingAddress,
        'amount' : totalAmount.toString(),
        'order_details' : jsonEncode(_orderDetails),
        'coupon_id' : cupounId??"",
      };
      var response = await http.post(
        _uri,
        body: body,
      );
      if (response.statusCode == 200) {
        return OrderResponse.fromJson(jsonDecode(response.body));
      } else
        return null;
      print(_orderDetails);
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<OrderHistory>> getOrderHistory(String customerID) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'order_history': '1',
          'customer_id': customerID,
        },
      );
      if (response.statusCode == 200) {
        List rawJson = jsonDecode(response.body);
        return rawJson.map((json) =>OrderHistory.fromJson(json)).toList();
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }



  ///registration




  static Future<AuthResponse> registerUser
      (String name,String email,String password,String phone,String address,String postcode,String city) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'register_account': '1',
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'address': address,
          'postcode': postcode,
          'city': city,
        },
      );
      if (response.statusCode == 200) {
        return AuthResponse.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<AuthResponse> loginUser
      (String email,String password) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'user_login': '1',
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        return AuthResponse.fromJson(jsonDecode(response.body));
      }
      else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<List<Review>> getReview
      (String productId) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'view_reviews': '1',
          'product_id': productId,
        },
      );
      if (response.statusCode == 200) {
        List rawList = jsonDecode(response.body);
        return rawList.map((json) => Review.fromJson(json)).toList();

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }


  static Future<AddReview> addReview
      ({String productId, String customerId, String remarks, String rating, String photo}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'add_review': '1',
          'product_id': productId,
          'customer_id': customerId,
          'remarks': remarks,
          'rating': rating,
          'photo': photo,
        },
      );
      if (response.statusCode == 200) {
        return AddReview.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }


  static Future<ForgotPasswordResponse> forgotPassword
      (String email) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'forgot_email': email,
        },
      );
      if (response.statusCode == 200) {
        return ForgotPasswordResponse.fromJson(jsonDecode(response.body));
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<HtmlContent> htmlContent
      (String page_id) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'html_content': '1',
          'page_id': page_id,
        },
      );
      if (response.statusCode == 200) {
        return HtmlContent.fromJson(jsonDecode(response.body)['data']);

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<List<SearchProduct>> searchProduct
      (String searchString) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'search_string': searchString,
        },
      );
      if (response.statusCode == 200) {
        List rawList = jsonDecode(response.body);
        return rawList.map((json) => SearchProduct.fromJson(json)).toList();

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<UpdateProfileResponse> updateProfile
      ({String customerId, String name, String email, String phone, String address, String postCode, String city, bool updatePassword, String newPassword}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'update_profile': '1',
          'customer_id': customerId,
          'name': name,
          'email': email,
          'rating': phone,
          'address': address,
          'postcode': postCode,
          'city': city,
          'update_password': updatePassword?'1':'0',
          'old_password': updatePassword?newPassword:"",
          'new_password': updatePassword?newPassword:"",
        },
      );
      if (response.statusCode == 200) {
        return UpdateProfileResponse.fromJson(jsonDecode(response.body));
      }
      else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<Map<String,dynamic>> getOrdersHistory
      (String customerId,String pageNo) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'order_history': '1',
          'customer_id': customerId,
          'page_no' : pageNo
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }


  static Future<String> contactUs
      ({String name, String email, String instaUrl, String subject, String message,}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'contact_us': '1',
          'name': name,
          'email': email,
          'instagram_url': instaUrl,
          'subject': subject,
          'message': message,
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['msg'];

      } else
        return "Some error accoured";
    }
    catch (e) {
      return "Some error accoured";
    }
  }
  static Future<CupounResponse> getDiscount
      (String cupounCode,String cartAmount) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'check_coupon': '1',
          'coupon_code': cupounCode,
          'cart_amount' : cartAmount
        },
      );
      if (response.statusCode == 200) {
        return CupounResponse.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

}



