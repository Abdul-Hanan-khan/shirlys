class FeaturedProducts {
  List<Product> products=[];
  int totalPages;

  FeaturedProducts({this.products, this.totalPages});

  FeaturedProducts.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    return data;
  }
}

class Product {
  bool isFav;
  String id;
  String title;
  String shortDetails;
  String longDetails;
  String salePrice;
  String photo;
  String categoryId;
  String subCategoryId;
  String reviews;
  String rating;
  String discountedPrice;
  String sizeGuide;
  String delivery;
  String liveDate;
  String type;
  String preOrderMessage;
  List<Size> sizes;
  List<Choice> choices;

  Product(
      {this.id,
        this.title,
        this.shortDetails,
        this.longDetails,
        this.salePrice,
        this.photo,
        this.categoryId,
        this.subCategoryId,
        this.reviews,
        this.rating,
        this.sizes,
        this.choices,
        this.discountedPrice,
        this.sizeGuide,
        this.liveDate,
        this.type,
        this.preOrderMessage,
        this.delivery});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDetails = json['short_details'];
    longDetails = json['long_details'];
    salePrice = json['sale_price'];
    photo = json['photo'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    reviews = json['reviews'];
    rating = json['rating'];
    discountedPrice = json['discounted_price'];
    sizeGuide = json ['size_guide'];
    delivery = json['delivery'];
    liveDate = json['live_date'];
    preOrderMessage = json['pre_order_msg'];
    type = json ['type'].toString();
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
    data['title'] = this.title;
    data['short_details'] = this.shortDetails;
    data['long_details'] = this.longDetails;
    data['sale_price'] = this.salePrice;
    data['photo'] = this.photo;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['reviews'] = this.reviews;
    data['rating'] = this.rating;
    data['discounted_price'] = this.discountedPrice;
    data['size_guide'] = this.sizeGuide;
    data['delivery'] = this.delivery;
    data['live_date'] = this.liveDate;
    data['type'] = this.type;
    data['pre_order_msg'] = this.preOrderMessage;
    if (this.sizes != null) {
      data['sizes'] = this.sizes.map((v) => v.toJson()).toList();
    }
    if (this.choices != null) {
      data['choices'] = this.choices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Size {
  String id;
  String title;

  Size({this.id, this.title});

  Size.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

class Choice {
  String id;
  String color;

  Choice({this.id, this.color});

  Choice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['color'] = this.color;
    return data;
  }
}
