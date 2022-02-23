// import 'package:cached_map/cached_map.dart';
// import 'package:get/get.dart';
// import 'package:shirleys/modal/featured_products_model.dart';
// import 'package:shirleys/modal/product_gallary.dart';
// import 'package:shirleys/modal/products.dart';
// import 'package:shirleys/services/http_services.dart';
//
// class FeaturedProductDetailScreenController extends GetxController{
//   var currentChoiceID = "".obs;
//   Rx<FeaturedProducts> product = FeaturedProducts().obs;
//   RxBool progressing = true.obs;
//   RxBool galleryLoading = true.obs;
//   int index=0;
//   Map<String,ProductGalleryModal> productGalleryByID = <String,ProductGalleryModal>{};
//
//
//
//
//   FeaturedProductDetailScreenController(this.product){
//     // this.currentChoiceID.value = product.value.choices.first.id;
//     this.currentChoiceID.value = product.value.products.first.id;
//   }
//   @override
//   Future<void> onInit()  {
//     loadGallary();
//
//
//     // product.value.choices.map((choice) async =>
//     // productGalleryByID[choice.id] = await HttpService.getProductGallery(product.value.id, choice.id));
//
//     super.onInit();
//   }
//
//
//   Future<void> loadGallary() async {
//     // loadCachedGallery();
//     product.value.choices.forEach((choice) async {
//       productGalleryByID[choice.id.toString()] =
//       await HttpService.getProductGallery(product.value.id, choice.id);
//       if(productGalleryByID!=null && productGalleryByID.length == product.value.choices.length)
//       {
//         print("loaded${choice.id}");
//         galleryLoading.value=false;
//         // cacheGallery();
//       }
//     });
//     return;
//
//   }
//
//   cacheGallery(){
//     final Map<String, dynamic> file = new Map<String, dynamic>();
//     productGalleryByID.forEach((key, value) {
//       file[key]= value.toJson();
//     });
//
//     Mapped.saveFileDirectly(file:file, cachedFileName: "gallery"+product.value.id);
//   }
//
// // loadCachedGallery(){
// //   final Map<String, dynamic> file = new Map<String, dynamic>();
// //     Mapped.loadFileDirectly(cachedFileName: "gallery"+product.value.id).then((gallery) {
// //       if(gallery!=null)
// //         {
// //           gallery.map((key, value) {
// //             productGalleryByID['$key'] = ProductGalleryModal.fromJson(value);
// //           });
// //           // productGalleryByID = file;
// //           galleryLoading.value = false;
// //         }
// //     });
// // }
//
//
// }
