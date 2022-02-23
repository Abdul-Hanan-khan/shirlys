import 'cart_modal.dart';

class OrderResponse {
  String customerStatus;
  String customerMsg;
  String orderStatus;
  String msg;

  OrderResponse(
      {this.customerStatus, this.customerMsg, this.orderStatus, this.msg});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    customerStatus = json['customer_status'];
    customerMsg = json['customer_msg'];
    orderStatus = json['order_status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_status'] = this.customerStatus;
    data['customer_msg'] = this.customerMsg;
    data['order_status'] = this.orderStatus;
    data['msg'] = this.msg;
    return data;
  }
}




class OrderDetail{
  List<OrderItem> orderItems=[];

  OrderDetail(List<Item> cartItems){
    cartItems.forEach((cartItem) {
      int index =
      orderItems.indexWhere((orderItem) => orderItem.productId==cartItem.id);
      if(index!=-1){
        orderItems[index].details.add(
            Details(amount: (double.parse(cartItem.salePrice)*cartItem.quantity).toString(),
                sizeId: cartItem.size.id,
                quantity: cartItem.quantity.toString(),
                choiceId: cartItem.choiceID));
        orderItems[index].reviseTotalAmount();
      }
      else
      {
        orderItems.add(OrderItem(productId: cartItem.id,details:[ Details(amount: (double.parse(cartItem.salePrice)*cartItem.quantity).toString(),sizeId: cartItem.size.id,quantity: cartItem.quantity.toString(),choiceId: cartItem.choiceID)],totalAmount:  double.parse(cartItem.salePrice)*cartItem.quantity));
      }
    });
  }

}




class OrderItem {
  String productId;
  List<Details> details;
  double totalAmount;

  OrderItem({this.productId, this.details, this.totalAmount});

  OrderItem.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = this.totalAmount;
    return data;
  }



  void reviseTotalAmount(){
    totalAmount = 0;
    details.forEach((detail) {
      totalAmount = totalAmount + double.parse(detail.amount);
    });
  }


}

class Details {
  String amount;
  String sizeId;
  String quantity;
  String choiceId;

  Details({this.amount, this.sizeId, this.quantity, this.choiceId});

  Details.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    sizeId = json['size_id'];
    quantity = json['quantity'];
    choiceId = json['choice_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['size_id'] = this.sizeId;
    data['quantity'] = this.quantity;
    data['choice_id'] = this.choiceId;
    return data;
  }
}