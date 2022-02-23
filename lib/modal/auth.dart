import 'package:cached_map/cached_map.dart';


class AuthResponse {
  String status;
  String msg;
  User user;

  AuthResponse({this.status, this.msg, this.user});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    user = json['record'] != null ? new User.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.user != null) {
      data['record'] = this.user.toJson();
    }
    return data;
  }
}


class User {
  String name;
  String email;
  String password;
  String phone;
  String address;
  String postcode;
  String city;
  String id;

  User(
      {this.name,
        this.email,
        this.password,
        this.phone,
        this.address,
        this.postcode,
        this.city,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
    postcode = json['postcode'];
    city = json['city'];
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['id'] = this.id;
    return data;
  }


  ///custom functions
  static Future<User> fromCache() async{
    Mapped cacheJson = await Mapped.getInstance();
    var cachedUser = cacheJson.loadFile(cachedFileName: "user");
    print("user from cache: $cachedUser");
    if(cachedUser==null)
      return null;
    else
      return User.fromJson(cachedUser);
  }

  /// member functions

  static Future<String> saveUserToCache(User user) async{
    Mapped cacheJson = await Mapped.getInstance();
    try{
      cacheJson.saveFile(file: user.toJson(), cachedFileName: "user");
    }
    catch(e){
      return "Failed to save user due to: $e";
    }
    return "Save user to cache successfully ";
  }



  static Future<String> deleteCachedUser()async{
    Mapped cacheJson = await Mapped.getInstance();
    try{
      cacheJson.deleteFile(cachedFileName: "user");
    }
    catch(e){
      return "Some Problem accoured while deleting user File:$e";
    }
    return "Deleted user to cache successfully";

  }


}