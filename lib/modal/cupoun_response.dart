class CupounResponse {
  String status;
  String couponId;
  String code;
  String discount;
  String newTotal;
  String msg;

  CupounResponse(
      {this.status,
        this.couponId,
        this.code,
        this.discount,
        this.newTotal,
        this.msg});

  CupounResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    couponId = json['coupon_id'];
    code = json['code'];
    discount = json['discount'];
    newTotal = json['new_total'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['coupon_id'] = this.couponId;
    data['code'] = this.code;
    data['discount'] = this.discount;
    data['new_total'] = this.newTotal;
    data['msg'] = this.msg;
    return data;
  }
}
