class OrderHistory {
  String id;
  String customerType;
  String customerId;
  String orderNotes;
  String amount;
  String isPaid;
  String paidAmount;
  String paidDate;
  String couponId;
  String couponAmount;
  String billingAddress;
  String status;
  String createdDate;
  String updatedDate;
  String processedDate;
  String outDeliveryDate;
  String deletedFlag;
  List<OrderDetails> orderDetails;

  OrderHistory(
      {this.id,
        this.customerType,
        this.customerId,
        this.orderNotes,
        this.amount,
        this.isPaid,
        this.paidAmount,
        this.paidDate,
        this.couponId,
        this.couponAmount,
        this.billingAddress,
        this.status,
        this.createdDate,
        this.updatedDate,
        this.processedDate,
        this.outDeliveryDate,
        this.deletedFlag,
        this.orderDetails});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerType = json['customer_type'];
    customerId = json['customer_id'];
    orderNotes = json['order_notes'];
    amount = json['amount'];
    isPaid = json['is_paid'];
    paidAmount = json['paid_amount'];
    paidDate = json['paid_date'];
    couponId = json['coupon_id'];
    couponAmount = json['coupon_amount'];
    billingAddress = json['billing_address'];
    status = json['status'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    processedDate = json['processed_date'];
    outDeliveryDate = json['out_delivery_date'];
    deletedFlag = json['deleted_flag'];
    if (json['order_details'] != null) {
      orderDetails = new List<OrderDetails>();
      json['order_details'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_type'] = this.customerType;
    data['customer_id'] = this.customerId;
    data['order_notes'] = this.orderNotes;
    data['amount'] = this.amount;
    data['is_paid'] = this.isPaid;
    data['paid_amount'] = this.paidAmount;
    data['paid_date'] = this.paidDate;
    data['coupon_id'] = this.couponId;
    data['coupon_amount'] = this.couponAmount;
    data['billing_address'] = this.billingAddress;
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['processed_date'] = this.processedDate;
    data['out_delivery_date'] = this.outDeliveryDate;
    data['deleted_flag'] = this.deletedFlag;
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  String id;
  String orderId;
  String productId;
  List<Details> details;
  String amount;
  String productTitle;
  String productPhoto;
  String categoryTitle;
  String subCategoryTitle;

  OrderDetails(
      {this.id,
        this.orderId,
        this.productId,
        this.details,
        this.amount,
        this.productTitle,
        this.productPhoto,
        this.categoryTitle,
        this.subCategoryTitle});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
    amount = json['amount'];
    productTitle = json['product_title'];
    productPhoto = json['product_photo'];
    categoryTitle = json['category_title'];
    subCategoryTitle = json['sub_category_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['amount'] = this.amount;
    data['product_title'] = this.productTitle;
    data['product_photo'] = this.productPhoto;
    data['category_title'] = this.categoryTitle;
    data['sub_category_title'] = this.subCategoryTitle;
    return data;
  }
}

class Details {
  String amount;
  String sizeId;
  String quantity;
  String choiceId;
  String choiceColor;
  String sizeTitle;

  Details(
      {this.amount,
        this.sizeId,
        this.quantity,
        this.choiceId,
        this.choiceColor,
        this.sizeTitle});

  Details.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    sizeId = json['size_id'];
    quantity = json['quantity'];
    choiceId = json['choice_id'];
    choiceColor = json['choice_color'];
    sizeTitle = json['size_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['size_id'] = this.sizeId;
    data['quantity'] = this.quantity;
    data['choice_id'] = this.choiceId;
    data['choice_color'] = this.choiceColor;
    data['size_title'] = this.sizeTitle;
    return data;
  }
}
