class Review {
  String id;
  String productId;
  String photo;
  String rating;
  String remarks;
  String createdDate;
  String name;

  Review(
      {this.id,
        this.productId,
        this.photo,
        this.rating,
        this.remarks,
        this.createdDate,
        this.name});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    photo = json['photo'];
    rating = json['rating'];
    remarks = json['remarks'];
    createdDate = json['created_date'];
    name = json['name'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['photo'] = this.photo;
    data['rating'] = this.rating;
    data['remarks'] = this.remarks;
    data['created_date'] = this.createdDate;
    data['name'] = this.name;
    return data;
  }
}