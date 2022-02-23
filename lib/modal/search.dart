class SearchProduct {
  String id;
  String title;
  String subCategoryId;
  String categoryTitle;
  String subCategoryTitle;

  SearchProduct(
      {this.id,
        this.title,
        this.subCategoryId,
        this.categoryTitle,
        this.subCategoryTitle});

  SearchProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subCategoryId = json['sub_category_id'];
    categoryTitle = json['category_title'];
    subCategoryTitle = json['sub_category_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sub_category_id'] = this.subCategoryId;
    data['category_title'] = this.categoryTitle;
    data['sub_category_title'] = this.subCategoryTitle;
    return data;
  }
}
