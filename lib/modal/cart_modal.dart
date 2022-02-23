import 'package:cached_map/cached_map.dart';
import 'package:shirleys/modal/products.dart';

class Cart {
  List<Item> items;

  Cart({this.items});

  Cart.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Item>();
      json['items'].forEach((v) {
        items.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  String id;
  int quantity;
  String title;
  String shortDetails;
  String longDetails;
  String salePrice;
  String discountedPrice;
  String photo;
  String categoryId;
  String subCategoryId;
  String reviews;
  String rating;
  Size size;
  String choiceID;
  List<Size> sizes;
  List<Choice> choices;

  Item(
      {this.id,
        this.quantity,
        this.title,
        this.shortDetails,
        this.longDetails,
        this.salePrice,
        this.discountedPrice,
        this.photo,
        this.categoryId,
        this.subCategoryId,
        this.reviews,
        this.rating,
        this.size,
        this.choiceID,
        this.sizes,
        this.choices});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    title = json['title'];
    shortDetails = json['short_details'];
    longDetails = json['long_details'];
    salePrice = json['sale_price'];

    discountedPrice = json['discounted_price'];

    photo = json['photo'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    reviews = json['reviews'];
    rating = json['rating'];
    size = json['size'] != null ? new Size.fromJson(json['size']) : null;
    choiceID = json['choiceID'];
    if (json['sizes'] != null) {
      sizes = new List<Size>();
      json['sizes'].forEach((v) {
        sizes.add(new Size.fromJson(v));
      });
    }
    if (json['choices'] != null) {
      choices = new List<Choice>();
      json['choices'].forEach((v) {
        choices.add(new Choice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['title'] = this.title;
    data['short_details'] = this.shortDetails;
    data['long_details'] = this.longDetails;
    data['sale_price'] = this.salePrice;

    data['discounted_price'] = this.discountedPrice;

    data['photo'] = this.photo;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['reviews'] = this.reviews;
    data['rating'] = this.rating;
    if (this.size != null) {
      data['size'] = this.size.toJson();
    }
    data['choiceID'] = this.choiceID;
    if (this.sizes != null) {
      data['sizes'] = this.sizes.map((v) => v.toJson()).toList();
    }
    if (this.choices != null) {
      data['choices'] = this.choices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


