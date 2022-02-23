class ProductGalleryModal {
  List<GalleryItem> galleryItems;

  ProductGalleryModal({this.galleryItems});

  ProductGalleryModal.fromJson(Map<String, dynamic> json) {
    if (json['gallery_item'] != null) {
      galleryItems = new List<GalleryItem>();
      json['gallery_item'].forEach((v) {
        galleryItems.add(new GalleryItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.galleryItems != null) {
      data['gallery_item'] = this.galleryItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GalleryItem {
  String id;
  String photo;

  GalleryItem({this.id, this.photo});

  GalleryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    return data;
  }
}
