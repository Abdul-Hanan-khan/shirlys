import 'package:shirleys/modal/sub_category.dart';

class CategoryModal {
  String id;
  String title;
  String banner;
  List<SubCategoryModal> subCategories;

  CategoryModal({this.id, this.title, this.subCategories, this.banner});

  CategoryModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    banner = json['banner'];
    if (json['sub_categories'] != null) {
      subCategories =  [];
      json['sub_categories'].forEach((v) {
        subCategories.add(new SubCategoryModal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['banner'] = this.banner;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


