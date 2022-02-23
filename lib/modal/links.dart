class Links {
  String disclaimer;
  String privacyPolicy;
  String termsAndConditions;

  Links({this.disclaimer, this.privacyPolicy, this.termsAndConditions});

  Links.fromJson(Map<String, dynamic> json) {
    disclaimer = json['disclaimer'];
    privacyPolicy = json['privacy_policy'];
    termsAndConditions = json['terms_and_conditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disclaimer'] = this.disclaimer;
    data['privacy_policy'] = this.privacyPolicy;
    data['terms_and_conditions'] = this.termsAndConditions;
    return data;
  }
}