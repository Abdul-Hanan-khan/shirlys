class UpdateProfileResponse {
  String passwordStatus;
  String status;
  String msg;

  UpdateProfileResponse({this.passwordStatus, this.status, this.msg});

  UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    passwordStatus = json['password_status'];
    status = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password_status'] = this.passwordStatus;
    data['status'] = this.status;
    data['msg'] = this.msg;
    return data;
  }
}
